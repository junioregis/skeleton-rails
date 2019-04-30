Rails.application.routes.draw do
  # Admin
  ActiveAdmin.routes(self)

  # Devise
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Docs
  unless Rails.env.production?
    get 'docs/:version', to: 'docs#postman', format: 'json'
  end

  # Version
  def version(version, &routes)
    constraint = ApiConstraint.new(version: version)
    scope(module: "v#{version}", constraints: constraint, &routes)
  end

  # OAuth 2.0
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  # V1
  version(1) do
    scope 'server', as: 'server' do
      get 'ping', to: 'server#ping'
    end

    scope 'me', as: 'me' do
      get 'profile', to: 'profiles#me'
      get 'preferences', to: 'preferences#index'
    end
  end

  match '*path', :to => 'api#routing_error', via: :all
end
