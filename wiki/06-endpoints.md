# 6.1. App

[https://api.domain.com](https://api.domain.com)

##### Endpoints:

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

# 6.2. Admin

[https://api.domain.com/admin](https://api.domain.com/admin)

Username | Password
---------|---------
admin    | admin

# 6.3. Portainer

[https://portainer.domain.com](https://portainer.domain.com)