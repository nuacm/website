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

  # Location for the rails PID file.
  PID_FILE = "tmp/pids/server.pid"

  # Define a collection of services the server uses to
  # check.
  SERVICES = {}

  SERVICES[:rails] = -> do
    File.exists? PID_FILE
  end

  class << self

    # Read the PID from the PID_FILE. This is the current
    # process id for the rails server.
    def pid
      File.read(PID_FILE)
    end

    # Start the server, using `rails`. This will deamonize it, and
    # create a pid file for the server in tmp/pids
    def start
      flags = "--daemon"
      system "rails server #{flags} > /dev/null 2>&1"
      sleep(0.1)
      rails?
    end

    def stop
      system "kill #{pid} > /dev/null 2>&1"
      sleep(0.1)
      not rails?
    end

    def hot_restart
      system "kill -signal_name USR2 #{pid} > /dev/null 2>&1"
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
