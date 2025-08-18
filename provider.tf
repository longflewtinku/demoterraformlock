terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.9.0"
    }
  }
  backend "s3" {
    bucket = "terraform-aug-17-22"
    key = "test/laxmikanth"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}