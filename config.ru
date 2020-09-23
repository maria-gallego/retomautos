# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# Uncomment this to get real time logging if needed
# https://devcenter.heroku.com/articles/logging
# $stdout.sync = true

run Rails.application
