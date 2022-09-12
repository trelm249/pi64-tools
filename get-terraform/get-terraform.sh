#!/bin/bash

# Set Variables
raw_ver=$(curl -sL https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r ".tag_name")
tver=${raw_ver:1}
cur_ver=$(terraform --version |head -1 |cut -d ' ' -f 2)

# check if latest is already installed
if [ ${raw_ver} == ${cur_ver} ]
then
  echo "The latest version of terraform is ${tver} and is already installed"
  sleep 5
  exit
else
  echo "Installing terraform ${tver}"
fi

#Install terraform
echo "downloading terraform version $tver"
curl "https://releases.hashicorp.com/terraform/${tver}/terraform_${tver}_linux_arm64.zip" -o "terraformv1x.zip"
sudo unzip -f terraformv1x.zip -d /usr/local/bin/
sudo chmod 755 /usr/local/bin/terraform
rm ./terraformv1x.zip
