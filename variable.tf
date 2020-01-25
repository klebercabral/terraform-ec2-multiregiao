variable "ec2_east" {
    default = {
        "ami_name_east"             = "IaaSWeek-806d52dafe9b7fddbc4f0d2d41086ed3cfa02a44"
        "ami_owners_east"           = "777015859311"
        "instance_type_east"        = "t2.micro"
        "subnet_east"               = "subnet-76f1d458"
        "key_name_east"             = "mac"
        "count_east"                = 2
        "provisioner_user_east"     = "ubuntu"
        "instance_tag_name_east"    = "HelloWorld"
        "remote_exec_east"          = "touch /tmp/test"
    }
}

variable "ec2_west" {
    default = {
        "ami_name_west"             = "ami-0dd655843c87b6930"
        "instance_type_west"        = "t2.micro"
        "subnet_west"               = "subnet-881e10d3"
        "key_name_west"             = "mac_west"
        "provisioner_user_west"     = "ubuntu"
        "instance_tag_name_west"    = "HelloWorld"
        "remote_exec_west"          = "touch /tmp/test"
    }
}