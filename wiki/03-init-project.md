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

# 3.4. Configure Slack API

##### 3.4.1. Create App

```https://api.slack.com/apps > Create New App```

##### 3.4.2. Create Bot User

```https://api.slack.com/apps > App > Bot Users > Add Bot User```

##### 3.4.3. Install App

```https://api.slack.com/apps > OAuth & Permissions > Install App to Workspace```

##### 3.4.4. Configure Credentials

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

# 3.4. Commit and push changes to your repository

# 3.5. Developer Commands

```scripts/dev.sh```

Command     | Info
------------|-----------------------------
init        | Initialize project structure
build       | Build services
gen-secret  | Generate secret
start       | Start services
stop        | Stop services
restart     | Restart services
terminal    | Open terminal
deploy      | Edit credentials
logs        | Show logs
