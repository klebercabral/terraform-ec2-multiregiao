data "aws_ami" "ubuntu_east" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ec2_east.ami_name_east}"]
  }

  owners = ["${var.ec2_east.ami_owners_east}"]
}

resource "aws_instance" "web" {
provider      = "aws"
  ami           = "${data.aws_ami.ubuntu_east.id}"
  instance_type = "${var.ec2_east.instance_type_east}"
  subnet_id     = "${var.ec2_east.subnet_east}"
  key_name      = "${var.ec2_east.key_name_east}"
  count         = "${var.ec2_east.count_east}"
  associate_public_ip_address = true
  security_groups = ["${var.ec2_east.security_groups_east}"]

    provisioner "remote-exec" {
      inline = [
        "${var.ec2_east.remote_exec_east}",
      ]
      connection {
        type     = "ssh"
        user     = "${var.ec2_east.provisioner_user_east}"
        private_key = "${file("mac.pem")}"
        host     = "${self.public_ip}"
      }
    }

  tags = {
    Name = "${var.ec2_east.instance_tag_name_east}"
  }
}

resource "aws_instance" "west" {
  provider      = "aws.west"
  ami           = "${var.ec2_west.ami_name_west}"
  instance_type = "${var.ec2_west.instance_type_west}"
  subnet_id     = "${var.ec2_west.subnet_west}"
  key_name      = "${var.ec2_west.key_name_west}"
  count         = "${var.ec2_west.count_west}"
  associate_public_ip_address = true
  security_groups = ["${var.ec2_west.security_groups_west}"]

    provisioner "remote-exec" {
      inline = [
        "${var.ec2_west.remote_exec_west}",
      ]
      connection {
        type     = "ssh"
        user     = "${var.ec2_west.provisioner_user_west}"
        private_key = "${file("mac_west.pem")}"
        host     = "${self.public_ip}"
      }
    }

  tags = {
    Name = "${var.ec2_west.instance_tag_name_west}"
  }
}