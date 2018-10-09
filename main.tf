provider "aws" {
  profile    = "${var.profile-name}"
  region     = "${var.aws-region}"
}
module "networking"
{
    source = "./network"
    vpc_cidr      = "${var.vpc_cidr}"
    public_cidr   = "${var.public_cidr}"
    my-ip         =  "${var.my-ip}"
}
module "compute"
{
    source = "./compute"
    key = "${var.key}"
    key-path="${var.key-path}"
    instance_type ="${var.instance_type}"
    vpc = "${module.networking.vpc}"
    subnet = "${module.networking.subnet}"
    security_group = "${module.networking.sg}"
}

