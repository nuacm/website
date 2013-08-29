# Be sure to restart your server when you modify this file.

# API Key for our mailchimp account.
Gibbon::API.api_key = ENV['MAILCHIMP_API_KEY'] || "05fede506b5ceda81efb5edfe000c7ed-us7"
Gibbon::API.timeout = 15
Gibbon::API.throws_exceptions = false