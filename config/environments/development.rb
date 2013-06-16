NUACM::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # Setup mailer.
  config.action_mailer.default_url_options = { :host => "localhost:3000" }

  # Secret key for verifying the integrity of signed cookies.
  NUACM::Application.config.secret_key_base = '0ddc82059964c93a840a8152b67f3111b8a32a06b8a346634bea9bc07ad792c4bad4dcb7afb194d777b1e2d4aef04c3630d0812e7dbf3d4d23f8f8d8260336b8'
end
