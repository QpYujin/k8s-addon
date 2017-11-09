#! /bin/bash

SECRET=$(aws iam create-access-key --user-name kops | grep SecretAccessKey | sed 's/^.*: //' | sed 's,",,g' | sed 's/,//g')
ACCESS_KEY=$(aws iam list-access-keys --user-name kops | grep AccessKeyId | sed 's/^.*: //' | sed 's,",,g' | sed 's/,//g')

echo AWS_SECRET_ACCESS_KEY=$SECRET> config.txt
echo AWS_ACCESS_KEY_ID=$ACCESS_KEY>> config.txt

echo AWS_SECRET_ACCESS_KEY
echo AWS_ACCESS_KEY_ID

