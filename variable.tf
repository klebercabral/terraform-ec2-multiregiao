variable "ami_name_east" {
  default = "IaaSWeek-806d52dafe9b7fddbc4f0d2d41086ed3cfa02a44"
}
variable "ami_owners_east" {
  default = "777015859311"
}

variable "instance_type_east" {
  default = "t2.micro"
}

variable "subnet_east" {
  default = "subnet-094416f4334e66510"
}

variable "key_name_east" {
  default = "mac"
}

variable "count_east" {
  default = 2
}

variable "security_groups_east" {
  default = "sg-01399a06156627e79"
}

variable "remote_exec_east" {
  default = "touch /tmp/test"
}

variable "provisioner_user_east" {
  default = "ubuntu"
}

variable "private_key_east" {
  default = "mac.pem"
}

variable "instance_tag_name_east" {
  default = "HelloWorld"
}

variable "ami_name_west" {
  default = "ami-0dd655843c87b6930"
}
#variable "ami_owners_west" {
#  default = "777015859311"
#}

variable "instance_type_west" {
  default = "t2.micro"
}

variable "subnet_west" {
  default = "subnet-0e0f3c7cfd074e330"
}

variable "key_name_west" {
  default = "mac_west"
}

variable "count_west" {
  default = 1
}

variable "security_groups_west" {
  default = "sg-05ce65c7457ab1909"
}

variable "remote_exec_west" {
  default = "touch /tmp/test"
}

variable "provisioner_user_west" {
  default = "ubuntu"
}

variable "private_key_west" {
  default = "mac_west.pem"
}

variable "instance_tag_name_west" {
  default = "HelloWorld"
}