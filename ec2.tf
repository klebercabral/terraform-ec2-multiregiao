data "aws_ami" "ubuntu_east" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_east]
  }

  owners = [var.ami_owners_east]
}

resource "aws_instance" "web" {
  provider = aws
  ami           = data.aws_ami.ubuntu_east.id
  instance_type = var.instance_type_east
  subnet_id     = var.subnet_east
  key_name      = var.key_name_east
  count         = var.count_east
  associate_public_ip_address = true
  security_groups = [var.security_groups_east]

    provisioner "remote-exec" {
      inline = [
        "{$var.remote_exec_east}",
      ]
      connection {
        type     = "ssh"
        user     = var.provisioner_user_east
        private_key = file(var.private_key_east)
        host     = self.public_ip
      }
    }

  tags = {
    Name = var.instance_tag_name_east
  }
}

#data "aws_ami" "ubuntu_west" {
#  most_recent = true
#
#  filter {
#    name   = "name"
#    values = [var.ami_name_west]
#  }
#
#  owners = [var.ami_owners_west]
#}

resource "aws_instance" "west" {
  provider = aws.west
  ami           = var.ami_name_west
  instance_type = var.instance_type_west
  subnet_id     = var.subnet_west
  key_name      = var.key_name_west
  count         = var.count_west
  associate_public_ip_address = true
  security_groups = [var.security_groups_west]

    provisioner "remote-exec" {
      inline = [
        "{$var.remote_exec_west}",
      ]
      connection {
        type     = "ssh"
        user     = var.provisioner_user_west
        private_key = file(var.private_key_west)
        host     = self.public_ip
      }
    }

  tags = {
    Name = var.instance_tag_name_west
  }
}