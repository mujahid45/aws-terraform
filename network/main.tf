provider "aws" {
  profile    = "${var.profile-name}"
  region     = "${var.aws-region}"
}
data "aws_availability_zones" "available" {}
resource "aws_vpc" "dev_vpc" {
  cidr_block       = "${var.vpc_cidr}"

  tags {
    Name = "dev_vpc"
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
resource "aws_subnet" "public-subnet" {
  vpc_id     = "${aws_vpc.dev_vpc.id}"
  cidr_block = "${var.public_cidr}"
  map_public_ip_on_launch = true
  avilability_zone = data.aws_availability_zone.avilable.name[0]
  tags {
    Name = "public-cidr"
  }
}

resource "aws_route_table_association" "public-route" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public-route.id}"
}
resource "aws_security_group" "dev-sec" {
  name        = "dev-sec"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.dev_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "http"
    cidr_blocks = ["${var.my-ip}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}
