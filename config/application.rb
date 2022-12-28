require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WaoRor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # config.api_only = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.middleware.use ActionDispatch::Flash
    config.to_prepare do
      Devise::SessionsController.layout "application"
      Devise::RegistrationsController.layout proc{ |controller| manager_signed_in? ? "admin" : "auth" }
      Devise::ConfirmationsController.layout "application"
      # Devise::UnlocksController.layout "your_layout_name"
      Devise::PasswordsController.layout "application"
    end
    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', 
          headers: :any, 
          methods: [:get, :patch, :put, :delete, :post, :options],
          :expose  => ['Authorization']
      end
    end
  end
end
