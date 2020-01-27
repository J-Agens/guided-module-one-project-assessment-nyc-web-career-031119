require 'bundler'
require 'colorize'
require 'tty-prompt'
############# ADDED FOR DATADOG EXERCISE ####################
require 'datadog/statsd'
statsd = Datadog::Statsd.new('localhost', 8125)

# while true do
#     statsd.increment('example_metric.increment', tags: ['environment:dev'])
#     statsd.decrement('example_metric.decrement', tags: ['environment:dev'])
#     statsd.count('example_metric.count', 2, tags: ['environment:dev'])
#     sleep 10
# end
statsd.event('An error occurred', 'Error message', alert_type='error', tags=['env:dev'])
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
