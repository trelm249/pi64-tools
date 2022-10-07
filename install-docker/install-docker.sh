#!/bin/bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/debian bullseye stable"
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
#dc_ver=$(curl -sL https://api.github.com/repos/docker/compose/releases/latest | jq -r ".tag_name")
#echo $dc_ver
#mkdir -p /usr/local/lib/docker/cli-plugins
#curl -L https://github.com/docker/compose/releases/download/$dc_ver/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/lib/docker/cli-plugins/docker-compose
#chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
#ln -s /usr/local/lib/docker/cli-plugins/docker-compose /usr/bin/docker-compose
