# Terraform script to setup simple Kafka and Zookeeper cluster.

## Required steps for setup

To run this script you need to initialize your AWS account with the following 
* Create a VPC, copy the ID in the file `dev/variables.tf` in field `vpc_id`
* Create a key to be used in the created EC2 instances, copy the key name in the field `key_name`
* Create a Route53 DNS zone and copy the id in the field `dns_zoneid`
* Update the DNS zone IDs in the field `subnet_ids` with the ones created with the VPC.

## Run

Run as normal terraform script `terraform apply`

## Test

Currently this script creates only one Kafka and Zookeeper brokers. Each in separate EC2 instance with public IP enabled
So, to access the Kafka or Zookeeper brokers, get the public IP from AWS console, and use it as normal 

```bash
./kafka-topics --zookeeper 54.252.131.54:2181 --create --topic test --partitions 10 --replication-factor 1
./kafka-console-producer --topic test --broker-list 13.54.54.25:9092
./kafka-console-consumer --topic test --bootstrap-server 13.54.54.25:9092  --from-beginning
```

## Future work

There are 2 parts need to be improved 

* Enable Route53 for Kafka and Zookeeper to use a static name for running brokers instead of using the EC2's public IPs.
* Use Auto-Scaling Group in Kafka and Zookeeper. This will require updating the Route53 entries manually in the user-data 
script of each instance. 