provider "aws" {
  profile    = "${var.profile-name}"
  region     = "${var.aws-region}"
}
resource "aws_vpc" "dev_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags {
    Name = "main"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.dev_vpc.id}"

  tags {
    Name = "dev-igw"
  }
}
resource "aws_route_table" "public-route" {
  vpc_id = "${aws_vpc.dev_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

 
  tags {
    Name = "public-route"
  }
}