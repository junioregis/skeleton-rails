# Introduction

This tutorial explains how to start dockerized Ruby on Rails 5.2

# Requirements

Name            | Version
----------------|-----------
Docker          | 18.03.0-ce
Docker-Compose  | 1.20.1

# Docker Images

Name           | Tag
---------------|--------
ruby           | 2.5.1
postgres       | 10.3
dpage/pgadmin4 | latest
nginx          | 1.13

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

# Build again with new Gemfile
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

Set this attributes for each database environment configuration on ```config/database.yml```:

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

# 8. App Access - development

[http://localhost:3000](http://localhost:3000)

# 9. PgAdmin Access - development

[http://localhost:8000](http://localhost:8000)

```
username: admin
password: admin
```

# 10. App Access - production

[http://localhost](http://localhost)
