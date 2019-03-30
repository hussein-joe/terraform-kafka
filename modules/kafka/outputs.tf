output "kafka_plaintext_security_group" {
  value = "${aws_security_group.kafka_plaintext.id}"
}

output "kafka_a01_ip" {
  value = "${aws_instance.kafka_a01.private_ip}"
}