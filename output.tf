output "ip_address" {
  value = "${aws_instance.web[*].public_ip}"
}
output "ip_address_west" {
  value = "${aws_instance.west[*].public_ip}"
}
