provider "aws" {
  version = "~> 2.0"
  region  = "ap-south-1"
}
 //create VPC
 resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
    Batch = "930am"
  }
}
