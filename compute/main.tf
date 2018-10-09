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
  

  tags {
    Name = "dev-instance"
  }
}
