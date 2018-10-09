output "vpc" {
  value = "${aws_vpc.dev_vpc.id}"
}
output "subnet" {
  value = "${aws_subnet.public-subnet.id}"
}
output "sg" {
  value = "${aws_security_group.dev-sec.id}"
}

