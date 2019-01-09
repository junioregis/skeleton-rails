# 1. Connect to Virtual Machine (host)

```bash
ssh ubuntu@domain.com
```

# 2. Configure User

```
```bash
sudo sh -c "echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
```

# 3. Configure Repositories

### 3.1 Generate Access Key

```bash
ssh-keygen -t rsa
```

### 3.2 Copy Generated Key

```bash
cat ~/.ssh/id_rsa.pub
```

### 3.3 Configure Repository

##### Bitbucket

```Bitbucket > Repository > Settings > Access Keys > Add Key > Key > PASTE KEY```

##### Github

```Github > Repository > Settings > Deploy Keys > Add Deploy Key > Key > PASTE KEY```

# 4. Install (host)

```bash
ssh ubuntu@domain.com 'bash -s' < scripts/vps/install.sh
```

```Wait for system rebooting```

# 5. Generate Certs (host)

```bash
scp -r certs ubuntu@domain.com:/tmp/
ssh ubuntu@domain.com 'bash -s' < scripts/vps/certs.sh
```
