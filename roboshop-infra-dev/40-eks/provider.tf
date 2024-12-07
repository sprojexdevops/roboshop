terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.0"
    }
  }

  backend "s3" {
    bucket         = "sprojex-remote-state"
    key            = "roboshop-eks"
    region         = "us-east-1"
    dynamodb_table = "tf-state-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}