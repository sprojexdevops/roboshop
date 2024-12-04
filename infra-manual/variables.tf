variable "instances" {
  type = map(any)
  default = {
    mongodb   = "t3.small"
    redis     = "t3.micro"
    mysql     = "t3.small"
    rabbitmq  = "t3.micro"
    catalogue = "t3.micro"
    user      = "t3.micro"
    cart      = "t3.micro"
    shipping  = "t3.small"
    payment   = "t3.micro"
    dispatch  = "t3.micro"
    frontend  = "t3.micro"
  }
}

variable "allow_all" {
  type    = string
  default = "sg-0fea5e49e962e81c9"
}

# variable "zone_id" {
#     default = "Z09912121MS725XSKH1TG"
# }

variable "domain_name" {
  default = "sprojex.in"
}