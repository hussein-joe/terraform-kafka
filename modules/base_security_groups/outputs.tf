output "allow_ssh" {
  value = "${aws_security_group.ssh.id}"
}

output "allow_outbound" {
  value = "${aws_security_group.allow_outbound.id}"
}
