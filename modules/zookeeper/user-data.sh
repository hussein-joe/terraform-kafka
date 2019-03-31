#!/usr/bin/env bash
# **NOTE** this file is templated by Terraform, single dollar is a Terraform value, double dollar is escaped

set -x

readonly ip=$(ifconfig eth0 | grep "inet " | awk '{print $$2}')


start_zookeeper() {

  sudo yum install -y docker
  sudo usermod -aG docker ec2-user
  sudo service docker start

  export HOSTNAME_COMMAND=$(curl "http://169.254.169.254/latest/meta-data/public-hostname")


  sudo docker run -d --net=host --name=zookeeper -e ZOOKEEPER_CLIENT_PORT=2181 -e ZOOKEEPER_TICK_TIME=2000 \
  confluentinc/cp-zookeeper:5.1.2
}

main() {
    start_zookeeper
}

main
