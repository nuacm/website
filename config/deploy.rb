set :user, "nixpulvis"
set :application, "nuacm"

# Temp fix till Ali gives me a SSH key.
# set :repository,  "git@github.com:nuacm/website.git"
# set :branch, "rails"
set :scm, :none
set :repository, "."
set :deploy_via, :copy

server "acm.ccs.neu.edu", :app, :web, :db, :primary => true

default_run_options[:pty] = true
default_run_options[:shell] = 'zsh'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end