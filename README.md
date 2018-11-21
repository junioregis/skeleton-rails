# Introduction

Complete guide to create Dockerized Ruby on Rails API with VirtualBox VM for deployment test.

# Operating System

```Ubuntu 16.04```

# 1. Configure Virtual Box

### 1.1 Create Host Network Adapter

```File > Host Network Manager > Create```

IPv4 Address | IPv4 Network Mask | DHCP Server
-------------|-------------------|------------
192.168.56.1 | 255.255.255.0     | DISABLED

### 1.2 Edit Network Interfaces

##### Execute:

```sudo nano /etc/network/interfaces```

```
auto lo
iface lo inet loopback

# Adapter 1: NAT
auto enp0s3
iface enp0s3 inet dhcp

# Adapter 2: Host-Only
auto enp0s8
iface enp0s8 inet static
address 192.168.56.10
netmask 255.255.255.0
```

##### Execute:

```sudo ifup enp0s8```

### 1.3 Configure Network Adapters 

##### Adapter 1

```Virtual Machine -> Settings -> Network -> Adapter 1 > Attached to > NAT```

##### Adapter 2

```Virtual Machine -> Settings -> Network -> Adapter 2 > Attached to > Host-only Adapter```

# 2. Configure Repositories

### Connect to Virtual Machine

```bash
ssh ubuntu@192.168.56.10
```

### Generate Access Key

```
ssh-keygen -t rsa
```

### Copy Generated Key

```
cat ~/.ssh/id_rsa.pub
```

### Add Keys

##### Bitbucket

```Bitbucket > Repository > Settings > Access Keys > Add Key > Key > PASTE VALUE```

##### Github

```TODO```

# 3. Configure Virtual Machine

### Install

```bash
ssh ubuntu@192.168.56.10 'bash -s' < scripts/vps/install.sh
```

```Waiting for system rebooting```

### Generate Certs

```bash
scp -r certs ubuntu@192.168.56.10:/tmp/
ssh ubuntu@192.168.56.10 'bash -s' < scripts/vps/certs.sh
```

# 4. Development

### Init

```bash
bash scripts/dev.sh init
```

Copy Master Key value inside ```./src/config/master.key``` to ```RAILS_MASTER_KEY``` variable inside ```./env/common.env``` 

### Build

```bash
bash scripts/dev.sh build
```

### Start

```bash
bash scripts/dev.sh start
```

### Developer Commands

```./scripts/dev.sh```

Command     | Info
------------|----------
init        | Initialize project structure
build       | Build services
start       | Start services
stop        | Stop services
logs        | Show logs
terminal    | Open terminal
permissions | Check permissions
credentials | Edit credentials

# 5. Access

### App

[http://localhost:3000](http://localhost:3000)

### PgAdmin

[http://localhost:8000](http://localhost:8000)

```
username: admin
password: admin
```

### Portainer

[http://localhost:9000](http://localhost:9000)

# 6. Deploy

### Enter terminal

```bash
bash scripts/dev.sh terminal
```

##### Deploy

```bash
# Check
cap production deploy:check
```

```bash
# First deploy
cap production deploy:init
```

```bash
# Deploy
cap production deploy
```

### Edit Hosts

```/etc/hosts```

```
192.168.56.10 api.domain.com
192.168.56.10 db.domain.com
192.168.56.10 portainer.domain.com
```

### Deployer Commands

```./scripts/prd.sh```

Command | Info
--------|----------
logs    | Show logs

# 7. Access

### App

[https://api.domain.com](https://api.domain.com)

### PgAdmin

[https://db.domain.com](https://db.domain.com)

### Portainer

[https://portainer.domain.com](https://portainer.domain.com)