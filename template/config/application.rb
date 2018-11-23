require_relative 'boot'

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true
    config.i18n.default_locale = :pt_BR
  
    config.middleware.use Rack::Attack
  end
end
