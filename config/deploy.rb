set :user, "nixpulvis"
set :application, "nuacm"
set :repository,  "git@github.com:nuacm/website.git"
set :branch, "rails"

server "acm.ccs.neu.edu", :app, :web, :db, :primary => true

default_run_options[:pty] = true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end