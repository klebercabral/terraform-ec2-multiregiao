variable "ami_name" {
}
variable "instance_type_s" {
}
variable "instance_type_m" {
}
variable "subnet" {
}
variable "key_name" {
}
variable "key_path" {
}
variable "provisioner_user" {
}
variable "instance_tag_name" {
}
variable "remote_exec" {
}

variable "ec2_count" {
}

variable "blocks" {
  type        = list(object({
      device_name = string
      volume_size = number
      volume_type = string
    }))
}