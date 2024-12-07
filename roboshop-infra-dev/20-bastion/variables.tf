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

variable "bastion_tags" {
  type = map(any)
  default = {
    Component = "bastion"
  }
}