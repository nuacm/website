# NUACM

Northeastern University ACM's website. In all it's glory, till someone decides they hate rails for a silly reason and kills it. (Don't make me find you)

## Ruby Version

This is a Ruby 2.0 application, and will make no attempts to make life easier for people using outdated rubies.

It is also a Rails 4 application, and will make no attempt to ease the lives of old Rails either. (Rails 4 beta currently)

## System dependencies

This application currently runs in production on Ubuntu 12.04, with the following installed.

* Passenger (with Nginx)
* Git
* Ruby 2.0 (and it's dependencies)
* Postgres SQL

## Database creation

Create the database, with rails. This will create both the development and test database unless on a production machine.

As with everything setting the all important `RAILS_ENV=production` will make it create the production database.

``` bash
rake db:create
```

## Tests

Running the tests is easy.

``` bash
rake
```

## Deployment

Deployment is handled with capistrano. Code is deploied to `acm.ccs.neu.edu`. You will need the `nixpulvis` password.

``` bash
cap deploy
```