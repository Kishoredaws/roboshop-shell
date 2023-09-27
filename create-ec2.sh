#!/bin/bash
NAMES=("mongodb" "mysql" "rabbitmq" "redis" "catalogue" "cart" "user" "payment" "dispatch" "shipping" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP=sg-01ea0eafb8976901c
for i in "${NAMES[@]}"
do
if [[$i == "mongodb" || $i == "mysql"]];
then
    INSTANCE_TYPE="t3.medium"
else
    INSTANCE_TYPE="t2.micro"
fi
    echo "The created instance is $i"
aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE  --security-group-ids $SECURITY_GROUP
done


