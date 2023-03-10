resource "aws_ssoadmin_permission_set" "example" {
  name         = "${local.csi}-example"
  description  = "Example Permission Set"
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]

  provider = aws.sso
}
