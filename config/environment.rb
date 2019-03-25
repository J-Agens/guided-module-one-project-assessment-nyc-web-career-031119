require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/ar.db'
)

require_all 'app'
require_all 'lib'
