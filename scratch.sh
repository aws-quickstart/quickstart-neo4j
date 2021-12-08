
coreMembers=$(aws autoscaling describe-auto-scaling-instances --region $region --output text --query "AutoScalingInstances[?AutoScalingGroupName=='Neo4jAutoScalingGroup'].InstanceId" | xargs -n1 aws ec2 describe-instances --instance-ids $ID --region $region --query "Reservations[].Instances[].PublicDnsName" --output text --filter "Name=tag:aws:cloudformation:stack-name,Values=$stackName")
coreMembers=$(echo $coreMembers | sed 's/ /:5000,/g')
coreMembers=$(echo $coreMembers):5000
