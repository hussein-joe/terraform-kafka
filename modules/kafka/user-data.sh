#!/usr/bin/env bash
# **NOTE** this file is templated by Terraform, single dollar is a Terraform value, double dollar is escaped

set -x

readonly ip=$(ifconfig eth0 | grep "inet " | awk '{print $$2}')


start_kafka() {
  echo "kafka started" >> /tmp/action
  echo ${zookeeper_hosts} >> /tmp/action
  echo ${broker_listeners_protocols} >> /tmp/action
  echo ${broker_listeners_ports} >> /tmp/action

  sudo yum install -y docker
  sudo usermod -aG docker ec2-user
  sudo service docker start

  export HOSTNAME_COMMAND=$(curl "http://169.254.169.254/latest/meta-data/public-hostname")


  sudo docker run -d \
    --net=host \
    --name=my-kafka \
    -e KAFKA_ZOOKEEPER_CONNECT=localhost:2181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$${HOSTNAME_COMMAND}:9092 \
    -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
    confluentinc/cp-kafka
}

main() {
    start_kafka
}

main
