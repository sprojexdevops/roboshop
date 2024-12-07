resource "aws_ssm_parameter" "https_cert_arn" {
  # /roboshop/dev/mysql_sg_id
  name  = "/${var.project_name}/${var.environment}/https_cert_arn"
  type  = "String"
  value = aws_acm_certificate.roboshop_https_cert.arn
}