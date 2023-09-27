#!/bin/bash
NAMES=("mongodb" "mysql" "rabbitmq" "redis" "catalogue" "cart" "user" "payment" "dispatch" "shipping" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP_ID=sg-01ea0eafb8976901c
for i in "${NAMES[@]}"
do
if [[ $i == "mongodb" || $i == "mysql" ]];
then
    INSTANCE_TYPE="t3.medium"
else
    INSTANCE_TYPE="t2.micro"
fi
    echo "Creating instance is $i"
IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE  --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress') 
    echo "The created instance $i : $IP_ADDRESS"
done


