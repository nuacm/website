# This is the command run after every git clone/pull.
# We need to ensure all the setup is done, and start
# the server. With Puma we can restart while live
# by sending the Puma server a signal.

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
      puts "Server is running."
    else
      puts "Server is not running."
    end
  end

  desc "Start up the server, if the server is already up just say that."
  task :start do
    if puma?
      puts "Server is already running."
    else
      puts "Starting the server..."
    end
  end

  desc "Stop the server, if it's not running just say that."
  task :stop do
    if puma?
      puts "Stopping the server..."
    else
      puts "Server is already stopped."
    end
  end

  desc "Restart the server, trying hot first, then cold."
  task :restart do
    if puma?
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
    task :cold => [:stop, :start] do
    end

    desc "Hot Restart the server without ever taking it down."
    task :hot do
      if puma?
        puts "Hot restarting the server..."
      else
        puts "Server is not running."
      end
    end
  end

end
