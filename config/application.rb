require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GiftCompassApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.load_defaults 7.0
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.{rb,yml}")]
    config.active_record.default_timezone = :local
    config.time_zone = 'Asia/Tokyo'
    
    # メーラーのプレビューをspecファイルにする
    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"

    config.generators do |g|
      g.helper false
      g.test_framework :rspec, fixture: false
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
