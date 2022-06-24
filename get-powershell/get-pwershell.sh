#!/bin/bash
# Get Powershell

# set variables
ps_ver=$(curl -sL https://api.github.com/repos/PowerShell/PowerShell/releases/latest | jq -r ".tag_name")
sps_ver=${ps_ver:1}
cur_ver=$(pwsh --version |cut -d ' ' -f 2)
# check if latest is already installed
if [ ${sps_ver} == ${cur_ver} ]
then
  echo "The latest version of powershell is ${sps_ver} and is already installed"
  sleep 5
  exit
else
  echo "Installing powershell ${ps_ver}"
fi
#get latest stable powershell version number
curl -L https://github.com/PowerShell/PowerShell/releases/download/${ps_ver}/powershell-${sps_ver}-linux-arm64.tar.gz -o ./powershell-${sps_ver}-linux-arm64.tar.gz
# remove existing older install
if [[ -d /usr/local/powershell ]]
then
  rm -rf /usr/local/powershell
fi
# install the latest version
mkdir /usr/local/powershell
tar -xzvf ./powershell-${sps_ver}-linux-arm64.tar.gz -C /usr/local/powershell
chmod +x /usr/local/powershell/pwsh
ln -s /usr/local/powershell/pwsh /usr/bin/pwsh
# cleanup post install
rm ./powershell-${sps_ver}-linux-arm64.tar.gz
# show latest installed version
pwsh --version
