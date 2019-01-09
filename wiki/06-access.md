# 1. App

[https://api.domain.com](https://api.domain.com)

##### Endpoints

Method | Path           | Header                     | Params
-------|----------------|----------------------------|----------------------------------
POST   | oauth/token    | -                          | assertion, provider, access_token
GET    | server/ping    | api-version, authorization | -
GET    | me/preferences | api-version, authorization | -
GET    | me/profile     | api-version, authorization | -

##### Docs:

Endpoint | Username | Password
---------|----------|---------
docs/v1  | admin    | admin

Set endpoints for Postman generator on file ```src/config/initializers/endpoints.rb```

# 2. Database Admin

[https://db.domain.com](https://db.domain.com)

```
username: admin
password: admin
```

# 3. Portainer

[https://portainer.domain.com](https://portainer.domain.com)
