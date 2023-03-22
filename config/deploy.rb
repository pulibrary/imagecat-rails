# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.0'

set :application, 'imagecat_rails'
set :repo_url, 'https://github.com/pulibrary/imagecat-rails'

set :linked_dirs, %w[log public/system public/assets]

set :branch, ENV['BRANCH'] || 'main'

set :deploy_to, '/opt/imagecat-rails'
# set :ssh_options, {verify_host_key: :never}
