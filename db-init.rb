require 'sqlite3'
require 'sequel'
require_relative 'config.rb'

DB = Sequel.connect("sqlite://#{PUCK_DB}")

# Create the quotes table
DB.create_table? :quotes do
  primary_key :id
  String :author, text: true
  String :quote, text: true
  Integer :server
  Integer :date
end

DB.create_table? :top do
  primary_key :id
  String :name, text: true
  String :discriminator, text: true
  Integer :server
  Integer :score, default: 0
  Integer :last_seen, default: 0
end
