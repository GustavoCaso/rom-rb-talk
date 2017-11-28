require 'rubygems'
require 'bundler/setup'
require 'rom-sql'
require 'rom'
require 'pp'
require_relative './lib/persistance/repositories/post_repository'
require_relative './lib/persistance/repositories/author_repository'

config = ROM::Configuration.new(:sql, "sqlite::memory")
config.auto_registration('./lib/persistance')
container = ROM.container(config)

container.gateways[:default].tap do |gateway|
  migration = gateway.migration do
    change do
      create_table :posts do
        primary_key :id
        foreign_key :author_id, :authors
        string :title, null: false
        string :body, null: false
        boolean :published, null: false, default: false
      end

      create_table :authors do
        primary_key :id
        string :email, null: false
        string :username, null: false
      end
    end
  end
  migration.apply gateway.connection, :up
end

post_repo = Persistance::Repositories::PostRepository.new(container)
author_repo = Persistance::Repositories::AuthorRepository.new(container)

gustavo = author_repo.create(email: 'gustavocaso@gmail.com', username: 'trapomania')
marcio = author_repo.create(email: 'marciobarrios@gmail.com', username: 'cuerpacio')

post_repo.create_with_author(author: gustavo, title: 'My new Post', body: 'Awesome (allthethings)')
post_repo.create_with_author(author: marcio, title: 'Why I go to the gym', body: 'To build my cuerpacio')
post_repo.create_with_author(author: gustavo, title: 'Using dry-rb at work', body: 'Would be awesome to use it by the way')

puts "Let's print a summary represeantation of all the post in the system"
puts '-' * 50
pp post_repo.overview
puts '-' * 50

puts "Let's get all the post that Marcio has created"
puts '-' * 50
pp post_repo.by_author(marcio)
puts '-' * 50
