# 4.1. Deploy to Heroku

##### Install Heroku Client

```bash
bash scripts/heroku.sh install-cli
```

##### First Deploy

Set Heroku app name in variable ```APP_NAME``` inside ```scripts/heroku.sh``` and execute:

```bash
bash scripts/heroku.sh first-deploy
```

##### Deploy

```bash
bash scripts/heroku.sh deploy
```

##### Commands

```scripts/heroku.sh```

Command      | Info
-------------|----------------------
install-cli  | Install Heroku client
first-deploy | First deploy
deploy       | Deploy
logs         | Show logs

# 4.2. Deploy to Virtual Machine

##### First Deploy

```bash
bash scripts/dev.sh first-deploy
```

##### Deploy

```bash
bash scripts/dev.sh deploy
```

##### Commands

```scripts/prd.sh```

Command      | Info
-------------|------------------
build        | Build services
setup        | Setup app
migrate      | Migrate database
start        | Start services
stop         | Stop services
restart      | Restart services
first-deploy | First deploy
deploy       | Deploy
logs         | Show logs