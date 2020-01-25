output "ip_address" {
  value = "${aws_instance.west.public_ip}"
}