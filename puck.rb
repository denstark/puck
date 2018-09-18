require 'discordrb'
require 'sqlite3'
require 'require_all'
require 'sequel'
require 'uri'
require 'json'
require 'net/http'
require 'geocoder'

require_relative 'config.rb'
DB = Sequel.connect("sqlite://#{PUCK_DB}")
$puck = Discordrb::Commands::CommandBot.new token: DISCORD_TOKEN, client_id: DISCORD_CLIENT_ID, prefix: 'p!'
require_relative 'commands.rb'
require_all 'lib/*.rb'

$puck.message() do |event|
  puts "#{event.user.name}@#{event.user.server.name}: #{event.content}"
  disc = event.user.discriminator
  name = event.user.name
  message = event.content.gsub(URI.regexp, '') # remove urls from messages since they can be cheaty
  length = (message.length / 4)
  if length < 1
    length = 1
  elsif length > 50
    length = 50
  end
  server = event.user.server.id

  topUsers = DB[:top]
  if topUsers.where(name: name, discriminator: disc, server: server).count > 0
    topAddScore(:name => name, :disc => disc, :server => server, :score => length)
  else
    topAddNewUser(:name => name, :disc => disc, :server => server)
    topAddScore(:name => name, :disc => disc, :server => server, :score => length)
  end
end

puts "This bot's invite URL is #{$puck.invite_url}."

$puck.run
