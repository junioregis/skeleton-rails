# 1.1. Create Host Network Adapter

```File > Host Network Manager > Create```

IPv4 Address | IPv4 Network Mask | DHCP Server
-------------|-------------------|------------
192.168.56.1 | 255.255.255.0     | DISABLED

# 1.2. Create Virtual Machine

CPU    | RAM     | HD
-------|---------|------
1 Core | 1024 MB | 20 GB

# 1.3. Configure Network Adapters 

##### Adapter 1

```Virtual Machine -> Settings -> Network -> Adapter 1 > Attached to > NAT```

##### Adapter 2

```Virtual Machine -> Settings -> Network -> Adapter 2 > Attached to > Host-only Adapter```

# 1.4. Download Ubuntu Server Image

*Ubuntu 16.04.5 - 64bit*

[https://www.ubuntu.com/download/alternative-downloads](https://www.ubuntu.com/download/alternative-downloads)

# 1.5. Install System

##### Credentials:

```
User: ubuntu
Pass: ubuntu
```

##### Install SSH Server:

```bash
sudo apt update && sudo apt install openssh-server
```

# 1.6. Configure Host

##### Edit Hosts

```
192.168.56.10 domain.com
192.168.56.10 api.domain.com
192.168.56.10 db.domain.com
192.168.56.10 portainer.domain.com
```

# 1.7. Edit Network Interfaces

##### Execute:

```bash
sudo nano /etc/network/interfaces
```

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

##### Restart:

```bash
sudo reboot
```

```Wait for system rebooting```