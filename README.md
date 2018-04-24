# Introduction

This tutorial explains how to start dockerized Ruby on Rails

# Requirements

Name            | Version
----------------|-----------
Docker          | 18.03.0-ce
Docker-Compose  | 1.20.1

# Docker Images

Name            | Version
----------------|-----------
Ruby            | 2.5.1
Rails           | 5.2.0
Postgres        | 10.3
PgAdmin         | latest
Nginx           | 1.13

# 1. Create Volumes

```docker
docker volume create --name=app_db
docker volume create --name=app_storage
```

# 2. Create Project Structure

```docker
docker-compose build
docker-compose up -d
docker-compose run app rails new . --force --skip-bundle --database=postgresql
docker-compose down

# Buld again with new Gemfile
docker-compose build
```

# 3. Config Master Key

Copy content of ```src/config/master.key``` file to ```RAILS_MASTER_KEY``` environment variable of service ```app``` in ```docker-compose.yml```

# 4. Edit Credentials

```
docker-compose up -d
docker-compose run -e EDITOR=nano app rails credentials:edit
docker-compose down
````

# 5. Config Database

Set this credentials on ```config/database.yml```:

```
host: db
user: postgres
password:
```

# 6. Start Service

```docker
docker-compose -f docker-compose.yml -f docker-compose.[environment].yml up -d
```

# 7. Create Database

```docker
docker-compose -f docker-compose.yml -f docker-compose.[environment].yml run app rake db:create
```

# 8. Access App (development)

[http://localhost:3000](http://localhost:3000)

# 9. Access PgAdmin (development)

[http://localhost:8000](http://localhost:8000)

# 10. Access App (production)

[http://localhost](http://localhost)