#!/bin/bash
raw_ver=$(curl -sL https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r ".tag_name")
tver=${raw_ver:1}
echo "downloading terraform version $tver"
curl "https://releases.hashicorp.com/terraform/${tver}/terraform_${tver}_linux_arm64.zip" -o "terraformv1x.zip"
sudo unzip -f terraformv1x.zip -d /usr/local/bin/
sudo chmod 755 /usr/local/bin/terraform
rm ./terraformv1x.zip
