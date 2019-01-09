Rails.application.routes.draw do
  def version(version, &routes)
    constraint = ApiConstraint.new(version: version)
    scope(module: "v#{version}", constraints: constraint, &routes)
  end

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  unless Rails.env.production?
    get 'docs/:version', to: 'docs#postman', format: 'json'
  end

  version(1) do
    scope 'server' do
      get 'ping', to: 'server#ping'
    end

    scope 'me' do
      get 'profile', to: 'profiles#me'
      get 'preferences', to: 'preferences#index'
    end
  end

  match '*path', :to => 'application#routing_error', via: :all
end
