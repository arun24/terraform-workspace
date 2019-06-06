provider "aws" {
	region = "${var.aws_region}"
}

terraform{
 backend "s3"{
 bucket = "arunreddy123-tf-may"
 key = "qua/javahomeapp/terraform.tfstate"
 region = "ap-south-1"
 }
}
