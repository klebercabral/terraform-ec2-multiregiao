data "aws_ami" "ubuntu_east" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ec2.ami_name_east]
  }

  owners = [var.ec2.ami_owners_east]
}

resource "aws_instance" "web" {
  provider = aws
  ami           = data.aws_ami.ubuntu_east.id
  instance_type = var.ec2.instance_type_east
  subnet_id     = var.ec2.subnet_east
  key_name      = var.ec2.key_name_east
  count         = var.ec2.count_east
  associate_public_ip_address = true
  security_groups = [var.ec2.security_groups_east]

    provisioner "remote-exec" {
      inline = [
        "${var.ec2.remote_exec_east}",
      ]
      connection {
        type     = "ssh"
        user     = var.ec2.provisioner_user_east
        private_key = file(var.ec2.private_key_east)
        host     = self.public_ip
      }
    }

  tags = {
    Name = var.ec2.instance_tag_name_east
  }
}

resource "aws_instance" "west" {
  provider = aws.west
  ami           = var.ec2.ami_name_west
  instance_type = var.ec2.instance_type_west
  subnet_id     = var.ec2.subnet_west
  key_name      = var.ec2.key_name_west
  count         = var.ec2.count_west
  associate_public_ip_address = true
  security_groups = [var.ec2.security_groups_west]

    provisioner "remote-exec" {
      inline = [
        "${var.ec2.remote_exec_west}",
      ]
      connection {
        type     = "ssh"
        user     = var.ec2.provisioner_user_west
        private_key = file(var.ec2.private_key_west)
        host     = self.public_ip
      }
    }

  tags = {
    Name = var.ec2.instance_tag_name_west
  }
}