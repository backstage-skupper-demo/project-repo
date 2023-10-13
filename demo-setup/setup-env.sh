#!/bin/bash

curl -LO https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_amd64.zip
unzip terraform_1.6.1_linux_amd64.zip
rm terraform_1.6.1_linux_amd64.zip
mv terraform /home/user/.local/bin