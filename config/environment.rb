require 'bundler'
require 'colorize'
require 'tty-prompt'
############# ADDED FOR DATADOG EXERCISE ####################
require 'datadog/statsd'

require 'rubygems'
require 'dogapi'

api_key = "00182545a0ebada08e843e3a94b16d03	"
application_key = "2a5206b6c115d0c661ff3dfb4f73a1a39e9ab99d"

dog = Dogapi::Client.new(api_key)
##############################################################
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/ar.db'
)

# STOP ACTIVERECORD LOGGING
ActiveRecord::Base.logger = nil

require_all 'app'
require_all 'lib'
