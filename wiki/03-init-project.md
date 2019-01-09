# 3.1. Initialize Project

```bash
bash scripts/dev.sh init
```

# 3.2. Start Services

```bash
bash scripts/dev.sh start
```

# 3.3. Configure Repository

Set repository url variable ```repo_url``` inside ```src/config/deploy.rb```

# 3.4. Configure Keys

###### 3.4.1. Set Environment Variables

Copy Master Key value inside ```src/config/master.key``` to:

- *RAILS_MASTER_KEY* variable inside ```env/common.env```
- *APP_MASTER_KEY* variable inside ```scripts/heroku.sh```

###### 3.4.2. Generate Secret

```bash
bash scripts/dev.sh gen-secret
 ```

Copy Secret Key value to *APP_SECRET* variable inside ```scripts/heroku.sh```

# 3.5. Configure Slack API

##### 3.5.1. Create App

```https://api.slack.com/apps > Create New App```

##### 3.5.2. Create Bot User

```https://api.slack.com/apps > App > Bot Users > Add Bot User```

##### 3.5.3. Install App

```https://api.slack.com/apps > OAuth & Permissions > Install App to Workspace```

##### 3.5.4. Configure Credentials

Copy Access Token:

```https://api.slack.com/apps > OAuth & Permissions > Bot User OAuth Access Token > COPY KEY```

Execute:

```bash
bash scripts/dev.sh credentials
```

Set credentials:

```
...

slack:
    token: <PASTE_TOKEN_HERE>
    channel: <PASTE_CHANNEL_NAME_HERE>
```

# 3.6. Developer Commands

```scripts/dev.sh```

Command     | Info
------------|-----------------------------
init        | Initialize project structure
build       | Build services
gen-secret  | Generate secret
start       | Start services
stop        | Stop services
restart     | Restart services
logs        | Show logs
terminal    | Open terminal
permissions | Check permissions
credentials | Edit credentials