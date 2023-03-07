## 2.1.0 (March 7, 2023)

 * Add the Governance API
 * Add support for AWS SSO as the IdP

## 2.0.1 (March 1, 2023)

 * Fix a bug; as is tradition.
 * locals_sources.tf was missing.
 * npx webpack had not been run after last change to frontend-deployer

## 2.0.0 (March 1, 2023)

 * Rename of Granted Approvals to Common Fate
 * Repository moved from from bjsscloud/terraform-aws-granted-approvals to bjsscloud/terraform-aws-common-fate
 * Main "Approvals" API handler function is now called "api", and the instances of API Gateway resources that provide the API itself are called "main", so as to distinguish them from the access_handler API which will in future be deprecated
 * All references to Granted have been changed to Common Fate, all references to Approvals have been changed to Main or API respectively.
 * There is a new "cache-sync" Lambda function
 * SSM Parameter prefix is now configurable
 * AWS IAM Identity Centre (SSO) region is now configurable
 * Upstream S3 Releases Bucket permissions fixed
 * .gitignore added
 * Deprecated locals_sources.tf release file name content

## 1.0.2 (October 12, 2022)

 * Fix README quoting

## 1.0.1 (October 12, 2022)

 * README and SSO Example fixes
 * Add CHANGELOG

## 1.0.0 (October 12, 2022)

 * Initial Release
