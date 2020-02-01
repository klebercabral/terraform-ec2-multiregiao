module "servers_east" {
    source = "./servers"
    providers = {
      aws = "aws"
    }
    ami_name = "${terraform.workspace == "production" ? "ami-04b9e92b5572fa0d1" : "ami-0d5d9d301c853a04a"}"
    instance_type = "t2.micro"
    subnet = "${terraform.workspace == "production" ? "subnet-76f1d458" : "subnet-f3b1ba9b"}"
    key_name = "lab"
    key_path = "lab.pem"
    provisioner_user = "ubuntu"
    instance_tag_name = "HelloWorld"
    remote_exec = "touch /tmp/test "
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

output "ip_address_east" {
  value = "${module.servers_east.ip_address}"
}
output "ip_address_east2" {
  value = "${module.servers_east.ip_address2}"
}

#output "ip_address_west" {
#  value = "${module.servers_west.ip_address}"
#}