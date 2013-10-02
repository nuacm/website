# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if Rails.env.production?
  NUACM::Application.config.secret_key_base = ENV['SECRET_KEY']
else
  NUACM::Application.config.secret_key_base = 'e372324fc6a231d1ae223fc2288d9f9cb576fb80a65c6e2fb0721d268979ff4684b349b7e37621e7f47de70fe24618c2dbae054e66255aadb1c5faa1a5ae6e13'
end
