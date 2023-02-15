# imagecat-rails

A rewrite of a imagecat.princeton.edu 
---
This catalog contains records for items cataloged before 1980.
Records are arranged alphabetically with authors, titles, and subjects interfiled.

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/pulibrary/imagecat-rails/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/pulibrary/imagecat-rails/tree/main)

## System dependencies

This project uses [asdf](https://asdf-vm.com/) (see .tool-versions for the current ruby version)

`bundle install` will install the dependencies for this project. 

## Database Setup

We use Postgres and run it via Lando in development.

Lando installation: [[https://github.com/lando/lando/releases]]

Startup: `rake servers:start`

## How to start application locally 

Run the `bin/rails server` command, then in a browser connect to [localhost:3000](http://localhost:3000/)

## How to run the test suite

`bundle exec rspec spec`

