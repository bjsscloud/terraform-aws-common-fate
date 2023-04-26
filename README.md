Common Fate
===========

Common Fate by Common Fate

* https://github.com/bjsscloud/terraform-aws-common-fate/
* https://github.com/common-fate/common-fate/
* https://commonfate.io/

Example Usage
-------------

### tfvars for component (root module)

```hcl
sso_common_fate = {
  enabled                = true
  administrator_group_id = "<Object ID of Azure AD Security Group for Common Fate Administrators>"
  azure_client_id        = "<IDP Syncer Azure App Registration Client ID>"
  azure_tenant_id        = "<Azure Tenant ID>"
  identity_provider_name = "<Descriptor for the Azure IDP (No spaces)>"
  identity_provider_type = "azure"
  saml_sso_metadata_url  = "https://login.microsoftonline.com/<Tenant ID>/federationmetadata/2007-06/federationmetadata.xml?appid=<Enterprise App ID>"
  sources_version        = "v0.5.0" # "dev/caef2f71a6cba469d1ff487a044b292c500db2ed"

  cognito_custom_image_base64 = "<Base64 Image Data>"
}
```

### Variables for component (root module)

```hcl
variable "sso_common_fate" {
  type        = map(any)
  description = "Configuration for Common Fate deployment"

  default = {
    enabled = false
  }
}
```

### Module call from component (root module), e.g. `components/sso/module_common_fate.tf`

```hcl
module "common_fate" {
  count  = var.sso_common_fate["enabled"] ? 1 : 0
  source = "bjsscloud/common-fate/aws"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  region         = var.region

  aws_sso_identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  aws_sso_instance_arn      = tolist(data.aws_ssoadmin_instances.main.arns)[0]

  public_hosted_zone_id = var.public_hosted_zone_id

  administrator_group_id    = lookup(var.sso_common_fate, "administrator_group_id", "common_fate_administrators")
  azure_client_id           = lookup(var.sso_common_fate, "azure_client_id", "")
  azure_tenant_id           = lookup(var.sso_common_fate, "azure_tenant_id", "")
  azure_email_identifier    = lookup(var.sso_common_fate, "azure_email_identifier", "mail")
  identity_provider_name    = lookup(var.sso_common_fate, "identity_provider_name", null)
  identity_provider_type    = lookup(var.sso_common_fate, "identity_provider_type", "cognito")
  saml_sso_metadata_content = lookup(var.sso_common_fate, "saml_sso_metadata_content", null)
  saml_sso_metadata_url     = lookup(var.sso_common_fate, "saml_sso_metadata_url", null)
  sources_version           = lookup(var.sso_common_fate, "sources_version", null)

  cognito_custom_image_file   = lookup(var.sso_common_fate, "cognito_custom_image_file", null)
  cognito_custom_image_base64 = lookup(var.sso_common_fate, "cognito_custom_image_base64", null)

  default_tags = local.default_tags
}
```

### `aws_ssoadmin_instances` Data Source in component (root module)

```hcl
data "aws_ssoadmin_instances" "main" {}
```

Configuration Steps for a complete Azure AD installation
========================================================

### 1. Prepare AAD Client Secret for Syncing Users & Groups

Based on documentation here: https://docs.commonfate.io/common-fate/providers/registry/commonfate/azure-ad/v1/setup

  1. https://portal.azure.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade
  2. New Application: `AWS <ENVIRONMENT> Common Fate Directory Sync`
     * a. Single Tenant (This Organization Directory Only)
     * b. Click Register
  3. API Permissions → Add
     * a. Use Application permissions from Microsoft Graph
          - i. `User.Read.All`
          - ii. `Group.Read.All`
          - iii. `GroupMember.Read.All`
     * b. Click Add Permissions
  4. Click Grant Admin Consent - Or request Consent be granted from AAD Administrators
  5. Certificates and Secrets
     * a. New Client Secret: " `AWS <ENVIRONMENT> Common Fate Directory Sync` "
     * b. Retrieve "Value" for later writing to Parameter Store
  6. Store Application (Client) ID for use in tfvars: `sso_common_fate["azure_client_id"]`
  7. Store Tenant ID for use in tfvars: `sso_common_fate["azure_tenant_id"]`

### 2. Prepare AzureAd Enterprise Application

Based on documentation here: https://docs.commonfate.io/common-fate/providers/registry/commonfate/azure-ad/v1/setup

  1. https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade
  2. Enterprise Applications → New → Create your own: " `AWS <ENVIRONMENT> Common Fate SSO` "
  3. Store Application ID for use in tfvars: `sso_common_fate["saml_sso_metadata_url"] = https://login.microsoftonline.com/<TENANT ID>/federationmetadata/2007-06/federationmetadata.xml?appid=<APPLICATION ID>`
  4. Set Reply URL and temporary Identifier:
     * a. Identifier: `urn:amazon:cognito:sp:eu-west-2_CHANGEME`
     * b. Reply URL.  Use  "i" if you are not passing a custom domain to Common Fate. Use "ii" if you are.
          - i. `https://<PROJECT>-<ENVIRONMENT>-sso-common-fate-web.auth.<REGION>.amazoncognito.com/saml2/idpresponse`
          - ii. `https://auth.common-fate.<ROOT DOMAIN NAME>/saml2/idpresponse`
  5. Assign Groups (Create as necessary)
     * a. Group for Admins: e.g. `EntApp-AWS-<ENVIRONMENT>-Common-Fate-Admins`
     * b. Group for User Access: e.g. `Core-AAD-Guests`
  6. Capture Admin Group Object ID for use in tfvars: `sso_common_fate["administrator_group_id"]`

### 3. Configure Terraform Environment

```hcl
sso_common_fate = {
  enabled                = true
  administrator_group_id = "<VALUE FROM STEP 2.6>"
  azure_client_id        = "<VALUE FROM STEP 1.6>"
  azure_tenant_id        = "<VALUE FROM STEP 1.7>"
  identity_provider_type = "azure"
  saml_sso_metadata_url  = "https://login.microsoftonline.com/a64cb840-fecf-45ea-a7e2-a7526e51be02/federationmetadata/2007-06/federationmetadata.xml?appid=<VALUE FROM STEP 2.3>"
  sources_version        = "v0.5.0" OR "dev/caef2f71a6cba469d1ff487a044b292c500db2ed"
}
```

### 4. Deploy Component (root module)

Presuming tfscaffold (https://github.com/tfutils/tfscaffold.git)

```bash
$ ./bin/terraform.sh -p <PROJECT> -g <GROUP> -e <ENVIRONMENT> -c sso -a apply
```

### 5. Update SAML Entity ID in AAD

  1. Update the `AWS <ENVIRONMENT> Common Fate SSO` Enterprise Application SAML Settings. Replace `CHANGEME` in Identitfier (Entity ID) with the value of the terraform output: `web_cognito_user_pool_id`

### 6. Configure Slack App

  1. Use the URL in the terraform output called `slack_app_create_url` to create a new Slack App
  2. Install to Workspace
  3. OAuth & Permisssions: Capture Bot User OAuth Token for use in Parameter Store

### 7. Write Secrets to Parameter Store

```bash
$ aws ssm put-parameter --name '/<SSM Parameter Prefix, i.e. common-fate>/secrets/identity/token' --value '<VALUE FROM STEP 1.5.b>' --type SecureString --overwrite
$ aws ssm put-parameter --name '/<SSM Parameter Prefix, i.e. common-fate>/secrets/notifications/slack/token' --value '<VALUE FROM STEP 6.3>' --type SecureString --overwrite
```

Using Slack incoming webhooks
=============================

[See the Common Fate documentation here](https://docs.commonfate.io/common-fate/configuration/slack#setup-instructions---slack-webhooks). Add the following variable to your module configuration:

```hcl
slack_incoming_webhook_urls = ["channel_name"]
```

Where `channel_name` is the identifier for your channel, like "common-fate-requests".

The Terraform module will create an SSM parameter as follows:

```
/<SSM Parameter Prefix, i.e. common-fate>/secrets/notifications/slackIncomingWebhooks/<channel name>/webhookUrl
```

In the above example if `common-fate-requests` is used as the channel identifier, the SSM parameter would be something like:

```
/common-fate/secrets/notifications/slackIncomingWebhooks/common-fate-requests/webhookUrl
```

The SSM Parameter prefix is `common-fate` by default, but can be overridden by providing the `ssm_parameter_prefix` module variable.

You will need to set the SSM parameter with the actual webhook value. You can do this as follows:

```
aws ssm put-parameter --name /common-fate/secrets/notifications/slackIncomingWebhooks/common-fate-requests/webhookUrl --value https://hooks.slack.com/services/XXXX/XXXXXX --type SecureString --overwrite
```