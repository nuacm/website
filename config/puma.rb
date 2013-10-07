# Run the server unattached to the terminal.
daemonize true

# Redirect logs.
stdout_redirect 'log/puma.log', 'log/puma.err'

# Specify quantity of threads.
threads 0, 16

if ENV['RAILS_ENV'] == "production"
  bind "unix://tmp/sockets/puma.sock"
else
  port 3000
end