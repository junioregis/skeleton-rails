# 5.1. Get Access Token from Provider

### Facebook

[https://developers.facebook.com/tools/explorer](https://developers.facebook.com/tools/explorer)

##### scopes:

```
email
user_gender
user_birthday
```

### Google

[https://developers.google.com/oauthplayground](https://developers.google.com/oauthplayground)

##### scopes:

```
https://www.googleapis.com/auth/userinfo.email
https://www.googleapis.com/auth/userinfo.profile
https://www.googleapis.com/auth/user.birthday.read
```

# 5.2. Get Authorization Token

```bash
curl --insecure -X POST \
     -H "Content-type: application/json" \
     -d '{"grant_type":"assertion", "provider":"facebook|google", "assertion":"<PROVIDER_ACCESS_TOKEN>"}' \
     "https://api.domain.com/oauth/token"
```

# 5.3. Ping Server

```bash
curl --insecure -X GET \
     -H "Content-type: application/json" \
     -H "Api-Version: 1" \
     -H "Authorization: Bearer <API_ACCESS_TOKEN>" \
     "https://api.domain.com/server/ping"
```

# 5.4. Refresh Token

```bash
curl --insecure -X POST \
     -H "Content-type: application/json" \
     -d '{"grant_type":"refresh_token", "refresh_token":"<API_ACCESS_TOKEN>"}' \
     "https://api.domain.com/oauth/token"
```