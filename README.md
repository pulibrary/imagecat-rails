# imagecat-rails

A rewrite of a imagecat.princeton.edu 
---
This catalog contains records for items cataloged before 1980.
Records are arranged alphabetically with authors, titles, and subjects interfiled.

## System dependencies

This project uses [asdf](https://asdf-vm.com/) (see .tool-versions for the current ruby version)

## How to start application locally 

To run this application locally, we run the command to create a new rails application with the name `imagecat-rails`.

`rails new --database=postgresql
--skip-test imagecat-rails`

We then run `bundle install` and `bundle update` if necessary to install our dependencies for this project. 

Using the rails framework for this project, to generate the application we will run the `bin/rails server` command, then in a browser connect to [localhost:3000](http://localhost:3000/)
