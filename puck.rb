require 'discordrb'
require 'sqlite3'
require 'require_all'

require_relative 'config.rb'
$db = SQLite3::Database.new QUOTES_DB

$puck = Discordrb::Commands::CommandBot.new token: DISCORD_TOKEN, client_id: DISCORD_CLIENT_ID, prefix: 'p!'
require_relative 'commands.rb'
require_all 'lib/*.rb'

$puck.message() do |event|
  puts "#{event.user.name}@#{event.user.server.name}: #{event.content}"
  disc = event.user.discriminator
  name = event.user.name
  length = event.content.length
  server = event.user.server.id
  if topUserExists?(:name => name, :disc => disc, :server => server)
    topAddScore(:name => name, :disc => disc, :server => server, :score => length)
  else
    topAddNewUser(:name => name, :disc => disc, :server => server)
    topAddScore(:name => name, :disc => disc, :server => server, :score => length)
  end
end

puts "This bot's invite URL is #{$puck.invite_url}."

$puck.run
