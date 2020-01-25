resource "aws_security_group" "ssh" {
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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name      = "name"
    values    = ["${var.ami_name}"]
  }

  owners      = ["${var.ami_owners}"]
}

resource "aws_instance" "web" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.subnet}"
  key_name                    = "${var.key_name}"
  count                       = "${var.servers}"
  vpc_security_group_ids      = ["${aws_security_group.ssh.id}"]

    provisioner "remote-exec" {
      inline = [
        "${var.remote_exec}",
      ]
      connection {
        type        = "ssh"
        user        = "${var.provisioner_user}"
        private_key = "${file("${var.key_path}")}"
        host        = "${self.public_ip}"
      }
    }
  tags = {
    Name = "${var.instance_tag_name}"
  }
}