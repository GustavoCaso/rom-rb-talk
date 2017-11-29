require 'rubygems'
require 'bundler/setup'
require 'rom'
require 'rom-yaml'
require 'pp'

db_file = File.expand_path('../db/users.yml', __FILE__)

config = ROM::Configuration.new(:yaml, db_file)
config.auto_registration('./lib/persistance')
container = ROM.container(config)

puts "Let's say we what to fetch an user by name"

puts '-' * 50
pp container.relations[:users].by_name('Jane').first
puts '-' * 50
