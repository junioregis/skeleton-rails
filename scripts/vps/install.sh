#!/bin/bash

TIMEZONE=America/Sao_Paulo
COMPOSE_VERSION=1.23.1

step() {
  echo -e "\n"
  echo "***************************************************************************"
  echo "*** $1"
  echo "***************************************************************************"
  echo -e "\n"
}

message() {
  echo -e "\n=> $1"
}

success() {
  message "SUCCESS"
}

failure() {
  message "FAILURE"
}

##################
# Initial Config #
##################

step "Initial Config"

sudo sh -c "echo '${USER} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"

success

############
# Timezone #
############

step "Timezone"

sudo ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
sudo sh -c "echo ${TIMEZONE} > /etc/timezone"

success

##############
# Essentials #
##############

step "Essentials"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
  build-essential \
  curl \
  git \
  nano \
  ufw \
  unzip \
  zip

success

############
# Firewall #
############

step "Firewall"

# Reset config
sudo ufw --force reset

# Allow ports
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Deny all by default
sudo ufw default deny

# Enable
sudo ufw --force enable

success

##########
# Docker #
##########

step "Docker"

# Install Dependencies
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  software-properties-common

# Configure Repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt-get update

# Install
sudo apt-get install -y docker-ce

# Configure
sudo usermod -aG docker ubuntu

success

##################
# Docker Compose #
##################

step "Docker Compose"

# Install
sudo curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# Configure
sudo chmod +x /usr/local/bin/docker-compose

success

################
# Clean System #
################

step "Clean System"

sudo apt-get autoremove
sudo apt-get clean

success

#################
# Reboot System #
#################

step "Reboot System"

message "REBOOTING SYSTEM..."

sudo reboot