#!/bin/bash
raw_ver=$(curl -sL https://api.github.com/repos/docker/compose/releases/latest | jq -r ".tag_name")
echo "downloading docker-compose version $raw_ver"
curl -L "https://github.com/docker/compose/releases/download/${raw_ver}/docker-compose-linux-aarch64" -o /usr/local/bin/docker-compose
sudo chmod 755 /usr/local/bin/docker-compose
