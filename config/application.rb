require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module NUACM
  class Application < Rails::Application
    config.autoload_paths << "#{config.root}/lib"

    # Set the server time to Eastern US.
    config.time_zone = "Eastern Time (US & Canada)"
  end
end
