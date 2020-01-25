variable "ec2_east" {
    default = {
        "ami_name_east" = "IaaSWeek-806d52dafe9b7fddbc4f0d2d41086ed3cfa02a44"
        "ami_owners_east" = "777015859311"
        "instance_type_east" = "t2.micro"
        "subnet_east" = "subnet-094416f4334e66510"
        "key_name_east" = "mac"
        "count_east" = 2
        "security_groups_east" = "sg-01399a06156627e79"
        "provisioner_user_east" = "ubuntu"
        "instance_tag_name_east" = "HelloWorld"
        "remote_exec_east" = "touch /tmp/test"
    }
}

variable "ec2_west" {
    default = {
        "ami_name_west" = "ami-0dd655843c87b6930"
        "instance_type_west" = "t2.micro"
        "subnet_west" = "subnet-0e0f3c7cfd074e330"
        "key_name_west" = "mac_west"
        "security_groups_west" = "sg-05ce65c7457ab1909"
        "provisioner_user_west" = "ubuntu"
        "instance_tag_name_west" = "HelloWorld"
        "remote_exec_west" = "touch /tmp/test"
    }
}