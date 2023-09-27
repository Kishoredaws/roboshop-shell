#!/bin/bash
NAMES=("mongodb", "mysql", "rabbitmq", "redis", "catalogue", "cart", "user", "payment", "dispatch", "shipping", "web")
for i in "${NAMES[@]}"
do
    echo "Name:$i"
    done

# aws ec2 run-instances --image-id ami-03265a0778a880afb --instance-type t2.micro  --security-group-ids sg-01ea0eafb8976901c

