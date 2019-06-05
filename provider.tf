provider "aws" {
  version = "~> 2.0"
  region  = "ap-south-1"
}
terraform{
 backend "s3"{
 bucket = "arunreddy123-tf-may"
 key = "dev/javahomeapp/terraform.tfstate"
 region = "ap-south-1"
 }
}
 //create VPC
 resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "terraform-vpc"
    Batch = "930am"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

#declareing a variable
 variable "vpc_cidr"{
 description = "choose cidr for vpc"
  default = 10.0.0.0/16

 }
