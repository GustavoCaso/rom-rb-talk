require 'rubygems'
require 'bundler/setup'
require 'rom'

configuration = ROM::Configuration.new(:sql, 'mysql2://root@localhost/corporate_pages_development')
configuration.auto_registration('./lib/persistance')
CONTAINER = ROM.container(configuration)

require 'pry'; binding.pry
