require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyGscraper
  class Application < Rails::Application
    # eg: AVAILABLE_LOCALES = 'en,th'
    config.i18n.available_locales = ENV.fetch('AVAILABLE_LOCALES').split(',')

    # eg: DEFAULT_LOCALE = 'en'
    config.i18n.default_locale = ENV.fetch('DEFAULT_LOCALE')

    # eg: FALLBACK_LOCALES = 'en,th'
    config.i18n.fallbacks = ENV.fetch('FALLBACK_LOCALES').split(',')

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
      
    # Set the queuing backend to `Sidekiq`
    # 
    # Be sure to have the adapter's gem in your Gemfile
    # and follow the adapter's specific installation
    # and deployment instructions.
    config.active_job.queue_adapter = :sidekiq

    # Prefix the queue name of all jobs with Rails ENV
    config.active_job.queue_name_prefix = Rails.env
  
    # Compress the responses to reduce the size of html/json controller responses.
    config.middleware.use Rack::Deflater

    # Automatically generate the `translation.js` files
    config.middleware.use I18n::JS::Middleware
end
end
