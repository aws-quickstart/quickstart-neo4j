#!/bin/bash

STACK_NAME=$1
REGION=`aws configure get region`

echo "Deleting stack $STACK_NAME"

aws cloudformation delete-stack \
--stack-name ${STACK_NAME} \
--region ${REGION}
