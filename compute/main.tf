data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}
resource "aws_key_pair" "dev-key" {
  key_name   = "dev-key"
  public_key = "$file(/home/ec2-user)"
}
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address =true
  vpc = "${var.vpc}"
  subnet= "$var.subnet"

  tags {
    Name = "dev-instance"
  }
  vpc_security_group_ids = "${var.security_group}"
  key_name = aws_key_pair.dev-key.id
}
