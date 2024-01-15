#!/bin/bash

SERVER_IP="{SERVER_IP:-192.168.0.10}"
SSH_USER="${SSH_USER:-$(whoami)}"
KEY_USER="${KEY_USER:-$(whoami)}"
DOCKER_VERSION="{DOCKER_VERSION:-1.8.3}"





function preseed_staging(){

cat << EOF

STAGING SERVER (DIRECT VIRTUAL MACHINE) DIRECTIONS:
   1. Configure a static IP address directly on the VM
        su 
           <enter password>
           nano /etc/network/interfaces
       [change the last line to look like this, remember to set the correct
        gateway for your router's IP address if it's not 192.168.1.1]
          iface eth0 inet static
             address ${SERVER_IP}
             netmask 255.255.255.0
             gateway 192.168.1.1
2. Reboot the VM and ensure the Debian CD is mounted
3. Install sudo
apt-get update && apt-get install -y -q sudo
4. Add the user to the sudo group
adduser ${SSH_USER} sudo
5. Run the commands in: $0 --help
Example:
./deploy.sh -a
EOF
}


function config_sudo (){
 echo "configuring passwordless sudo ..."
 scp "sudo/sudoers" "${SSH_USER}@{SERVER_IP}:/tmp/sudoers"

# bash -c "' '" used for non-interactive shell command. When you are running a script or a command remotely through SSH,
# you usually want a non-interactive shell because you don't have a user sitting at the terminal to provide interactive input.
ssh -t "${SSH_USER}@{SERVER_IP}"  bash -c "'
sudo chmod 440 /tmp/sudoers
sudo chown root:root /tmp/sudoers
sudo mv /tmp/sudoers /etc '"
echo "done!"
}


		

function add_ssh_key() {

echo "adding ssh key"
cat "$HOME/.ssh/id_rsa.pub" | ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
mkdir /home/${KEY_USER}.ssh
cat >> /home/${KEY_USER}.ssh/authorized keys
'"
	ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'
chmod 700 /home/${KEY_USER}/.ssh
chmod 640 /home/${KEY_USER}/.ssh/authorized_keys
sudo chown ${KEY_USER}:${KEY USER} -R /home/${KEY_USER}/.ssh '"
}



function configure_secure_ssh () {
echo "Configuring secure SSH..."
scp "ssh/sshd_config" "${SSH_USER}@${SERVER_IP]:/tmp/sshd_config"
ssh -t "${SSH_USER} @${SERVER_IP}" bash -c "'
sudo chown root: root /tmp/sshd_config
sudo mv /tmp/sshd_config /etc/ssh
sudo systemctl restart ssh'"
I
echo "done!"
}


function install docker () {
echo "Configuring Docker v$1..."
ssh -t "${SSH_USER}@${SERVER_IP}" bash -c "'

sudo apt-get update
sudo apt-get install -y -q libapparmorl aufs-tools ca-certificates
wget -0 "docker.deb https://apt.dockerproject.org/repo/pool/main/d/docker-engine/docke gine_${1}-0-jessie_amd64
sudo dpkg -1 docker.deb
rm docker.deb
sudo usermad -aG docker "${KEY_USER}"
'"
echo "done!"
}



function provision server () {
configure sudo
echo
add ssh key
echo "---"
configure_secure_ssh
echo "---"
install docker $1
}


function help menu () {
cat << EOF
Usage: ${0} (-h| -S| -u -k-sd [docker_ver] -a [docker_ver])
ENVIRONMENT VARIABLES:
SERVER IP
SSH USER
IP address to work on, ie. staging or production
Defaulting to ${SERVER_IP]
User account to ssh and scp 1 as
Defaulting to ${SSH_USER}
SSH USER

Defaulting to ${SERVER_IP]
User account to ssh and scp 1 as
Defaulting to ${SSH_USER}

EOF
}

﻿

while [[ $# >  0 ]]
do
case "$1" in
-S|--preseed-staging) preseed_staging
shift
;;
-u|--sudo)
configure_sudo
shift
-k |--ssh-key)
add_ssh_key
shift
;;
-s|--ssh)
configure_secure_ssh
shift
-d|--docker)
install_docker "${2: -${DOCKER_VERSION}}"
shift
-a|--all)
provision_server "${2: ${DOCKER_VERSION}}"
shift
-h|--help) help_menu
 shift
;;
*)
echo "${1} is not a valid flag, try running: $0 --help"
;;
esac 
shift
done
I
