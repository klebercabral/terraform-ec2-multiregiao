module "servers" {
    source = "./servers"
    ami_name = "IaaSWeek-806d52dafe9b7fddbc4f0d2d41086ed3cfa02a44"
    ami_owners = "777015859311"
    instance_type = "t2.micro"
    subnet = "subnet-76f1d458"
    key_name = "lab"
    key_path = "lab.pem"
    servers = 2
    provisioner_user = "ubuntu"
    instance_tag_name = "HelloWorld"
    remote_exec = "touch /tmp/test "
}
output "ip_address" {
  value = "${module.servers.ip_address}"
}