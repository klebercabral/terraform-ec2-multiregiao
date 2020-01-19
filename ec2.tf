data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["IaaSWeek-${var.hash_commit}"]
  }

  owners = ["777015859311"] # My User
}

resource "aws_instance" "web" {
  provider = aws
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = "subnet-094416f4334e66510"
  key_name      = "mac"
  count         = 2
  associate_public_ip_address = true
  security_groups = ["sg-01399a06156627e79"]

    provisioner "remote-exec" {
      inline = [
        "touch /tmp/test",
      ]
      connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = "${file("mac.pem")}"
        host     = "${self.public_ip}"
      }
    }

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_instance" "west" {
  provider = aws.west
  ami           = "ami-0dd655843c87b6930"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0e0f3c7cfd074e330"
  key_name      = "mac_west"
  associate_public_ip_address = true
  security_groups = ["sg-05ce65c7457ab1909"]

    provisioner "remote-exec" {
      inline = [
        "touch /tmp/test",
      ]
      connection {
        type     = "ssh"
        user     = "ubuntu"
        private_key = "${file("mac_west.pem")}"
        host     = "${self.public_ip}"
      }
    }

  tags = {
    Name = "HelloWorld"
  }
}