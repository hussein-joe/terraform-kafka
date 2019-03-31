output "zookeeper_a01_ip" {
  value = "${aws_instance.zookeeper_a01.public_ip}"
}

output "zookeeper_a01_dns" {
  value = "${aws_instance.zookeeper_a01.public_dns}"
}
