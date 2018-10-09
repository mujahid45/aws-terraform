provider "aws" {
  profile    = "${var.profile-name}"
  region     = "${var.aws-region}"
}
resource "aws_vpc" "dev_vpc" {
  cidr_block       = $"var.vpc_cidr"

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
resource "aws_subnet" "public-subnet" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.public_cidr}"

  tags {
    Name = "public-cidr"
  }
}

resource "aws_route_table_association" "public-route" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.public-route.id}"
}
