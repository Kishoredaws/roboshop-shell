#!/bin/bash
NAME=$@
NAMES=("mongodb" "mysql" "rabbitmq" "redis" "catalogue" "cart" "user" "payment" "dispatch" "shipping" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP_ID=sg-01ea0eafb8976901c
DOMAIN_NAME=kishoremerugudevops.online
HOSTED_ZONE_ID=Z00920562NQGNYOPKAAQ3
for i in $@
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

aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch '
{
            "Comment": "CREATE/DELETE/UPSERT a record ",
            "Changes": [{
            "Action": "CREATE",
                        "ResourceRecordSet": {
                                    "Name": "$i.$DOMAIN_NAME",
                                    "Type": "A",
                                    "TTL": 300,
                                 "ResourceRecords": [{ "Value": "'$IP_ADDRESS'"}]
}}]
}
'
done 
 