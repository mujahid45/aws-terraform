/*data "aws_ami_ids" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
}*/


resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.key}"
  public_key = "${file(var.key_path)}"
}


resource "aws_instance" "web" {
  ami           = "ami-0912f71e06545ad88"
  instance_type = "${var.instance_type}"
  associate_public_ip_address =true
  
  subnet_id = "${var.subnet}"

  tags {
    Name = "dev-instance"
  }
  vpc_security_group_ids = ["${var.security_group}"]
  key_name = "vpc"
  provisioner "remote-exec" {
    inline = [
      "sudo  yum update",
      "sudo apt-get install -y httpd"
    ]
    connection {
      type        = "ssh"
      agent       = false
      private_key = "${file("//home/ec2-user/vpc.pub")}"
      user        = "ec2-user"
    }  
  }
}
