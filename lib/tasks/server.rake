# These are rake tasks for managing the rails server.

# Prints to the screen. Levels are :default,
# :success, :warning, and :error.
def say(message, level=:default)
  string = if level == :default
    message
  else
    prefix = "[#{level.capitalize}]"
    "#{prefix} #{message}"
  end

  puts string
end

# Wrap the server control functionality.
class Server
  # Define a collection of services the server uses to
  # check.
  SERVICES = {}

  SERVICES[:puma] = -> do
    [true, false].sample
  end

  SERVICES[:postgres] = -> do
    [true, false].sample
  end

  class << self
    def start
      say "Starting server..."
      [true, false].sample
    end

    def stop
      say "Stoping server..."
      [true, false].sample
    end

    def hot_restart
      say "Hot Restarting server..."
      [true, false].sample
    end

    def running?
      result = true
      SERVICES.each do |_, check|
        result &&= check.call
      end
      result
    end

    # Define predicate methods for each service.
    SERVICES.each do |name, check|
      define_method("#{name}?", check)
    end
  end
end

namespace :server do

  desc "Get the status of the servers parts."
  task :status do
    if Server.running?
      say "Server is running."
    else
      say "Server is not running."
    end
  end

  desc "Start up the server, if the server is already up just say that."
  task :start do
    if Server.running?
      say "Server is already running.", :warning
    else
      if Server.start
        say "Server started.", :success
      else
        say "Starting server failed.", :error
      end
    end
  end

  desc "Stop the server, if it's not running just say that."
  task :stop do
    if Server.running?
      if Server.stop
        say "Server stopped.", :success
      else
        say "Stopping server failed.", :error
      end
    else
      say "Server is already stopped.", :warning
    end
  end

  desc "Restart the server, trying hot first, then cold."
  task :restart do
    if Server.running?
      begin
        run "server:restart:hot"
      rescue
        run "server:restart:cold"
      end
    else
      run "server:restart:cold"
    end
  end

  namespace :restart do
    desc "Restart the server, if it's not running just say that."
    task :cold => [:stop, :start]

    desc "Hot Restart the server without ever taking it down."
    task :hot do
      if Server.running?
        if Server.hot_restart
          say "Server hot restarted.", :success
        else
          say "Hot restarting server failed.", :error
        end
      else
        say "Server is not running.", :error
      end
    end
  end

end
