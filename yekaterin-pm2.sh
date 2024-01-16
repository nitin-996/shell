#!/bin/bash

set -e

ec2_ip="3.131.123.31"
user="ubuntu"
key="/home/cliffex/nitin/aws servers logins/schedassit(docufend)/yekaterin/kathronix.pem"


# ssh session started

ssh -i "$key" "$user"@"$ec2_ip" << "EOF"

sudo su
pm2 restart api

EOF