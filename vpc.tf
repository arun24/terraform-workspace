provider "aws" {
  region  = "ap-south-1"
}

locals{
 azs = "${data.aws_availability_zones.azs.names}"
}

resource "aws_vpc" "myvpc"{
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"
  tags = "${ var.vpc_tags}"

}

resource  "aws_subnet" "main"{
 count = "${length(locals.azs)}"
 vpc_id ="${aws_vpc.myapp_vpc.id}"
 cidr_block = "${element(var.subnet_cidrs, count.index)}"
 aws_availability_zones = "${element(locals.azs, count.index)}"
 tags = "${var.public_sub_tags}"

}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.myapp_vpc.id}"

  tags = {
    Name = "javahome_gw"
  }
}

  #create custom routetable

  resource "aws_route_table" "r" {
    vpc_id = "${aws_vpc.myapp_vpc.id}"

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
    }
          tags = {
      Name = "public-routetable"
    }
  }

  resource "aws_route_table_association" "a" {
   count = "${length(local.azs)}"
 subnet_id      = "${element(aws_subnet.main*.id, count.index)}"
 route_table_id = "${aws_route_table.r.id}"
}
