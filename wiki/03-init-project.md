# 1. Initialize Project

```bash
bash scripts/dev.sh init
```

# 2. Start Services

```bash
bash scripts/dev.sh start
```

# 3. Configure Repository

Set repository url value ```repo_url``` inside ```src/config/deploy.rb```

# 4. Configure Keys

###### 4.1. Set Environment Variables

Copy Master Key value inside ```src/config/master.key``` to:

- *RAILS_MASTER_KEY* variable inside ```env/common.env```
- *APP_MASTER_KEY* variable inside ```scripts/heroku.sh```

###### 4.2. Generate Secret

```bash
bash scripts/dev.sh gen-secret
 ```

Copy Secret Key value to *APP_SECRET* variable inside ```scripts/heroku.sh```

# 5. Configure Slack API

##### 5.1. Create App

```https://api.slack.com/apps > Create New App```

##### 5.2. Create Bot User

```https://api.slack.com/apps > App > Bot Users > Add Bot User```

##### 5.3. Install App

```https://api.slack.com/apps > OAuth & Permissions > Install App to Workspace```

##### 5.4. Configure Credentials

Copy Access Token:

```https://api.slack.com/apps > OAuth & Permissions > Bot User OAuth Access Token > COPY KEY```

Execute:

```bash
bash scripts/dev.sh credentials
```

Set Variables:

```
...

slack:
    token: <PASTE_TOKEN_HERE>
    channel: <PASTE_CHANNEL_NAME_HERE>
```

# 6. Developer Commands

```scripts/dev.sh```

Command     | Info
------------|-----------------------------
init        | Initialize project structure
build       | Build services
gen-secret  | Generete secret
start       | Start services
stop        | Stop services
restart     | Restart services
logs        | Show logs
terminal    | Open terminal
permissions | Check permissions
credentials | Edit credentials
