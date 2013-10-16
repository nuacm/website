# NUACM

[![Build Status](https://travis-ci.org/nuacm/website.png?branch=master)](https://travis-ci.org/nuacm/website)

Northeastern University ACM's website. This readme will walk through the steps required to get the site up and running for development.

## Getting started

Following the following setup steps will get you up and running with this project. If you are familiar with the rails stack feel free to ignore any of the parts of this that you already know.

This guide assumes you have git installed on your computer. If this is not the case, please install git before continuing. Github and many other sites have detailed instructions on installing git. If you are on OSX I highly recommend getting [Homebrew](http://brew.sh) and running `brew install git` from the terminal.

### Postgres

Postgres can be installed using a system package manager. If you are on a Mac like I said above use [Homebrew](http://brew.sh) to install postgres. `brew install postgres`. If you have trouble getting postgres on installed there are a million resources online to help with it.

### Ruby

I highly recommend using [rbenv](https://github.com/sstephenson/rbenv) to manage rubies (versions of ruby). Along with [ruby-build](https://github.com/sstephenson/ruby-build) it can manage and install ruby and it's system dependencies.

Open up your terminal and run the following commands one after another.

    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    exec $SHELL -l
    rbenv install 2.0.0-p0
    gem install bundler
    rbenv rehash

You now have a system with ruby fully installed.

### The ACM Website

To get the site up and running you need to install the project's dependencies. Ruby makes dealing with dependencies super easy with gems. The Gemfile is a manifest of all the dependencies needed by the project.

1. `bundle install` from within the project folder to install all the dependencies.
2. `rake db:create` to create the database through rails.
3. `rake db:migrate` to setup the proper tables in the database through rails.

Now the site is ready to go. Congratulation!

### Development

The following commands are the most commonly used in development. You should know about them.

* `rails s` Starts the webserver on [localhost:3000](http://localhost:3000).
* `rails c` Starts a interactive rails console.
* `rake spec` or `rake` Runs the projects tests.
* `rake -T` Lists all tasks available to use.

To view the changes being made to the code live run `rails s` and view the site in the browser at [localhost:3000](http://localhost:3000), changes made to the site in `app/` will be updated without restarting the server.
