variable "plus" {
  default = 1
}
module "servers_east" {
  source = "./servers"
  providers = {
    aws = "aws"
  }
  #ami_name          = "${terraform.workspace == "production" ? "ami-04b9e92b5572fa0d1" : "ami-0d5d9d301c853a04a"}"
  ami_name          = "ami-04b9e92b5572fa0d1"
  instance_type_s   = "t2.micro"
  instance_type_m   = "t3.medium"
  #subnet            = "${terraform.workspace == "production" ? "subnet-76f1d458" : "subnet-f3b1ba9b"}"
  subnet            = "subnet-f3b1ba9b"
  key_name          = "lab"
  key_path          = "lab.pem"
  provisioner_user  = "ubuntu"
  instance_tag_name = "HelloWorld"
  remote_exec       = "touch /tmp/test"
  #ec2_count         = "${terraform.workspace == "production" ? "2" + var.plus : "1"}"
  ec2_count         = 1 + var.plus
  blocks = [
    {
        device_name = "/dev/sdg"
        volume_size = 5
        volume_type = "gp2"
    },
    {
        device_name = "/dev/sdh"
        volume_size = 10
        volume_type = "gp2"
    },
  ]
}

#module "servers_west" {
#    source = "./servers"
#    providers = {
#      aws = "aws.west"
#    }
#    ami_name = "ami-0dd655843c87b6930"
#    instance_type = "t2.micro"
#    subnet = "subnet-881e10d3"
#    key_name = "lab"
#    key_path = "lab.pem"
#    provisioner_user = "ubuntu"
#    instance_tag_name = "HelloWorld"
#    remote_exec = "touch /tmp/test "
#}

output "ip_address_web" {
  value = "${module.servers_east.ip_address}"
}
output "ip_address_web2" {
  value = "${module.servers_east.ip_address2}"
}

#output "ip_address_west" {
#  value = "${module.servers_west.ip_address}"
#}