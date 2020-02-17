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

resource "aws_instance" "web" {
  count                  = "${var.ec2_count}"
  ami                    = "${var.ami_name}"
  instance_type          = "${count.index < 1 ? var.instance_type_s : var.instance_type_m}"
  subnet_id              = "${var.subnet}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  dynamic "ebs_block_device" {
    for_each = var.blocks
    content {
      device_name = ebs_block_device.value["device_name"]
      volume_size = ebs_block_device.value["volume_size"]
      volume_type = ebs_block_device.value["volume_type"]
    }
  }

  #provisioner "remote-exec" {
  #  inline = [
  #    "${var.remote_exec}",
  #  ]
  #  connection {
  #    type        = "ssh"
  #    user        = "${var.provisioner_user}"
  #    private_key = "${file("${var.key_path}")}"
  #    host        = "${self.public_ip}"
  #  }
  #}
  tags = {
    Name = "%{ if var.instance_tag_name != "" }${var.instance_tag_name}%{ else }Untagged%{ endif }!"
  }
}

resource "aws_eip" "ip" {
  vpc      = true
  count    = "${var.ec2_count}"
  instance = "${element(aws_instance.web.*.id, count.index)}"
  depends_on = ["aws_instance.web"]
}

resource "aws_instance" "web2" {
  ami                    = "${var.ami_name}"
  instance_type          = "${var.instance_type_s}"
  subnet_id              = "${var.subnet}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  #provisioner "remote-exec" {
  #  inline = [
  #    "${var.remote_exec}",
  #  ]
  #  connection {
  #    type        = "ssh"
  #    user        = "${var.provisioner_user}"
  #    private_key = "${file("${var.key_path}")}"
  #    host        = "${self.public_ip}"
  #  }
  #}
  tags = {
    Name = "${var.instance_tag_name}"
  }
  depends_on = ["aws_instance.web"]
}