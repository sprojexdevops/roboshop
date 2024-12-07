variable "project_name" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project     = "roboshop"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "rds_tags" {
  type = map(any)
  default = {
    Component = "mysql"
  }
}

variable "zone_name" {
  type    = string
  default = "sprojex.in"
}