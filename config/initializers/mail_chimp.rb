# API Key for our mailchimp account.
#
# Be sure to restart your server when you modify this file.

if Rails.env.production? && ENV['MAILCHIMP_API_KEY'].nil?
  raise "ENV['MAILCHIMP_API_KEY'] not set."
end

Gibbon::API.api_key = ENV['MAILCHIMP_API_KEY']
Gibbon::API.timeout = 15
Gibbon::API.throws_exceptions = false