Rails.application.routes.draw do
  def version(version, &routes)
    constraint = ApiConstraint.new(version: version)
    scope(module: "v#{version}", constraints: constraint, &routes)
  end

  version(1) do
    scope 'auth' do
      post 'token', to: 'auth#token'
    end
  
    scope 'server' do
      get 'ping', to: 'server#ping'
    end

    scope 'me' do
      get 'profile', to: 'profiles#me'
    end

    scope 'me' do
      get 'preferences', to: 'preferences#index'
    end
  end

  match '*path', :to => 'application#routing_error', via: :all
end
