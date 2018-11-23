# Introduction

Complete guide to create Dockerized Ruby on Rails Api REST inside Virtual Box with Capistrano deployment.

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

### 2.1 Connect to Virtual Machine

```bash
ssh ubuntu@192.168.56.10
```

### 2.2 Generate Access Key

```
ssh-keygen -t rsa
```

### 2.3 Copy Generated Key

```
cat ~/.ssh/id_rsa.pub
```

### 2.4 Add Keys

##### Bitbucket

```Bitbucket > Repository > Settings > Access Keys > Add Key > Key > PASTE KEY```

##### Github

```Github > Repository > Settings > Deploy Keys > Add Deploy Key > Key > PASTE KEY```

# 3. Configure Virtual Machine

### 3.1 Install

```bash
ssh ubuntu@192.168.56.10 'bash -s' < scripts/vps/install.sh
```

```Waiting for system rebooting```

### 3.2 Generate Certs

```bash
scp -r certs ubuntu@192.168.56.10:/tmp/
ssh ubuntu@192.168.56.10 'bash -s' < scripts/vps/certs.sh
```

# 4. Development

### 4.1 Initialize Project

```bash
bash scripts/dev.sh init
```

##### 4.1.1 Configure Master Key

Copy Master Key value inside ```./src/config/master.key``` to ```RAILS_MASTER_KEY``` variable inside ```./env/common.env``` 

##### 4.1.2 Configure Slack API

```https://api.slack.com```

Get ```Bot User OAuth Access Token``` and configure credentials.

Execute:

```bash
bash scripts/dev.sh credentials
```

```
...

slack:
    token: <PASTE_TOKEN_HERE>
    channel: <PASTE_CHANNEL_NAME>
```

Restrt Services:

```bash
bash scripts/dev.sh restart
```

### 4.2 Build

```bash
bash scripts/dev.sh build
```

### 4.3 Start

```bash
bash scripts/dev.sh start
```

### Developer Commands

```./scripts/dev.sh```

Command     | Info
------------|-----------------------------
init        | Initialize project structure
build       | Build services
start       | Start services
stop        | Stop services
restart     | Restart services
logs        | Show logs
terminal    | Open terminal
permissions | Check permissions
credentials | Edit credentials

# 5. Access

### 5.1 Get Access Token from Provider

##### Facebook

```https://developers.facebook.com/tools/explorer```

scopes:

```
email
user_gender
```

##### Google

```https://developers.google.com/oauthplayground```

scope:

```
https://www.googleapis.com/auth/userinfo.email
https://www.googleapis.com/auth/userinfo.profile
```

### 5.2 Get Authorization Token

```
curl -X POST -H 'Content-type: application/json; charset:utf-8' \
             -H 'Api-Version: 1' \
             --data '{"provider":"<PROVIDER>", \
                      "provider_id":"<PROVIDER_ID>", \
                      "access_token":"<ACCESS_TOKEN>"}' \
        http://localhost:3000/auth/token
```

### 5.3 Ping Server

```
curl -X GET -H 'Content-type: application/json; charset:utf-8' \
            -H 'Api-Version: 1' \
            -H 'Authorization: "Bearer <TOKEN_HERE>"' \
        http://localhost:3000/server/ping
```

### PgAdmin

[http://localhost:8000](http://localhost:8000)

```
username: admin
password: admin
```

### Portainer

[http://localhost:9000](http://localhost:9000)

# 6. Deploy

### 6.1 Enter terminal

```bash
bash scripts/dev.sh terminal
```

### 6.2 Deploy

##### First Deploy

```bash
cap production deploy:init
```

##### Deploy

```bash
cap production deploy
```

### Deployer Commands

```./scripts/prd.sh```

Command | Info
--------|----------
logs    | Show logs

### 6.3 Edit Hosts

```/etc/hosts```

```
192.168.56.10 api.domain.com
192.168.56.10 db.domain.com
192.168.56.10 portainer.domain.com
```

# 7. Access

### App

[https://api.domain.com](https://api.domain.com)

### PgAdmin

[https://db.domain.com](https://db.domain.com)

### Portainer

[https://portainer.domain.com](https://portainer.domain.com)