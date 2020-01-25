resource "aws_security_group" "ssh_east" {
  provider    = "aws"
  name        = "ssh_web"
  description = "ssh_web"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh"
  }
}

data "aws_ami" "ubuntu_east" {
  most_recent = true

  filter {
    name      = "name"
    values    = ["${var.ec2_east.ami_name_east}"]
  }

  owners      = ["${var.ec2_east.ami_owners_east}"]
}

resource "aws_instance" "web" {
  provider                    = "aws"
  ami                         = "${data.aws_ami.ubuntu_east.id}"
  instance_type               = "${var.ec2_east.instance_type_east}"
  subnet_id                   = "${var.ec2_east.subnet_east}"
  key_name                    = "${var.ec2_east.key_name_east}"
  count                       = "${var.ec2_east.count_east}"
  vpc_security_group_ids      = ["${aws_security_group.ssh_east.id}"]

    provisioner "remote-exec" {
      inline = [
        "${var.ec2_east.remote_exec_east}",
      ]
      connection {
        type        = "ssh"
        user        = "${var.ec2_east.provisioner_user_east}"
        private_key = "${file("lab.pem")}"
        host        = "${self.public_ip}"
      }
    }
  tags = {
    Name = "${var.ec2_east.instance_tag_name_east}"
  }
}

resource "aws_security_group" "ssh_west" {
  provider    = "aws.west"
  name        = "ssh_web"
  description = "ssh_web"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_instance" "west" {
  provider                    = "aws.west"
  ami                         = "${var.ec2_west.ami_name_west}"
  instance_type               = "${var.ec2_west.instance_type_west}"
  subnet_id                   = "${var.ec2_west.subnet_west}"
  key_name                    = "${var.ec2_west.key_name_west}"
  vpc_security_group_ids      = ["${aws_security_group.ssh_west.id}"]

    provisioner "remote-exec" {
      inline = [
        "${var.ec2_west.remote_exec_west}",
      ]
      connection {
        type        = "ssh"
        user        = "${var.ec2_west.provisioner_user_west}"
        private_key = "${file("lab.pem")}"
        host        = "${self.public_ip}"
      }
    }

  tags = {
    Name = "${var.ec2_west.instance_tag_name_west}"
  }
}