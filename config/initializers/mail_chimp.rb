# Be sure to restart your server when you modify this file.

# API Key for our mailchimp account.
Gibbon::API.api_key = ENV['MAILCHIMP_API_KEY']
Gibbon::API.timeout = 15
Gibbon::API.throws_exceptions = false