json = Jbuilder.new

json.info do
  json._postman_id SecureRandom.uuid
  json.name "API - #{@version}"
  json.schema 'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'
end

json.item @endpoints do |endpoint|
  json.name endpoint[:name]

  if endpoint[:test]
    event = {
        listen: 'test',
        script: {id: SecureRandom.uuid, exec: endpoint[:test], type: 'text/javascript'}
    }

    json.event [event]
  end

  json.request do
    json.auth do
      json.type 'noauth'
    end

    json.method endpoint[:method].to_s.upcase

    json.header endpoint[:headers] do |h|
      json.key h[:key]
      json.value h[:value]
    end

    if endpoint[:body]
      json.body do
        json.mode 'raw'
        json.raw endpoint[:body].to_json
      end
    end

    json.url do
      json.raw "https://api.domain.com/#{endpoint[:name]}"
      json.protocol 'https'
      json.host %w(api.domain.com)
      json.port ''
      json.path endpoint[:name].split('/')
    end
  end

  json.response []
end
