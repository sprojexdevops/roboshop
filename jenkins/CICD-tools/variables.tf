variable "zone_name" {
  type        = string
  default     = "sprojex.in"
  description = "description"
}

variable "sg_id" {
  type    = list(string)
  default = ["xxxxxxxxxxxxx"]
}

variable "subnet_id" {
  type    = string
  default = "xxxxxxxxxxx"
}