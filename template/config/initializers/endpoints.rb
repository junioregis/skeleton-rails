content_type = {key: 'Content-Type', value: 'application/json'}

default_headers = [
    content_type,
    {key: 'Api-Version', value: '1'},
    {key: 'Authorization', value: '{{auth}}'}
]

$endpoints = []
$endpoints << {name: 'oauth/token',
               method: :post,
               headers: [content_type],
               body: {
                   grant_type: 'assertion',
                   provider: 'facebook|google',
                   assertion: 'PROVIDER_ACCESS_TOKEN'
               },
               test: [
                   'response = JSON.parse(responseBody);',
                   '',
                   'token_type = response.token_type;',
                   'access_token = response.access_token;',
                   '',
                   'pm.globals.set("auth", token_type + " " + access_token)'
               ]
}

$endpoints << {name: 'server/ping', method: :get, headers: default_headers}
$endpoints << {name: 'me/profile', method: :get, headers: default_headers}
$endpoints << {name: 'me/preferences', method: :get, headers: default_headers}
