data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}
resource "aws_key_pair" "dev-key" {
  key_name   = "${var.key}"
  public_key = "${file(var.key-path)}"
}
resource "aws_instance" "web" {
  ami           = "ami-0e6d2e8684d4ccb3e"
  instance_type = "${var.instance_type}"
  associate_public_ip_address =true
  
  subnet_id = "${var.subnet}"

  tags {
    Name = "dev-instance"
  }
  vpc_security_group_ids = ["${var.security_group}"]
  key_name = "${aws_key_pair.dev-key.id}"
}
