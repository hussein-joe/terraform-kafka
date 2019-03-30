#!/usr/bin/env bash
# **NOTE** this file is templated by Terraform, single dollar is a Terraform value, double dollar is escaped

set -x

readonly ip=$(ifconfig eth0 | grep "inet " | awk '{print $$2}')


start_kafka() {
  echo "kafka started" >> /tmp/action
  echo "$${zookeeper_hosts}" >> /tmp/action
  echo "$${broker_listeners_protocols}" >> /tmp/action
  echo "$${broker_listeners_ports}" >> /tmp/action
}

main() {
    start_kafka
}

main
