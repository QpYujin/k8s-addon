#! /bin/bash

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export KOPS_STATE_STORE=qpair-state-store
export NAME=$3

kops delete cluster $NAME

ACCESS_KEY=$(aws iam list-access-keys --user-name kops | grep AccessKeyId | sed 's/^.*: //' | sed 's,",,g' | sed 's/,//g')

aws iam delete-access-key --access-key-id $ACCESS_KEY --user-name kops 
