require 'discordrb'
require 'sqlite3'
require_relative 'config.rb'
$db = SQLite3::Database.new QUOTES_DB


$puck = Discordrb::Commands::CommandBot.new token: DISCORD_TOKEN, client_id: DISCORD_CLIENT_ID, prefix: 'p!'
require_relative 'commands.rb'


$puck.message() do |event|
  puts "#{event.user.name}@#{event.user.server.name}: #{event.content}"
end

puts "This bot's invite URL is #{$puck.invite_url}."



$puck.run
