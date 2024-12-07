variable "project_name" {
  type    = string
  default = "roboshop"
}

variable "environment" {
  type    = string
  default = "dev"
}

# variable "sg_name" {
#   type    = string
# }

variable "common_tags" {
  type = map(any)
  default = {
    Project     = "roboshop"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "mysql_sg_tags" {
  type = map(any)
  default = {
    Component = "mysql"
  }
}

################
# bastion tags #
################
variable "bastion_sg_tags" {
  type = map(any)
  default = {
    Component = "bastion"
  }
}
