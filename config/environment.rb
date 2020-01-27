require 'bundler'
require 'colorize'
require 'tty-prompt'
############# ADDED FOR DATADOG EXERCISE ####################
require 'datadog/statsd'
statsd = Datadog::Statsd.new('localhost', 8125)
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
