require 'discordrb'
require_relative 'commands.rb'
require_relative 'config.rb'

puck = Discordrb::Bot.new token: DISCORD_TOKEN, client_id: DISCORD_CLIENT_ID


puck.message() do |event|
  puts "#{event.user.name}@#{event.user.server.name}: #{event.content}"
  if ! /^p\!.+/.match(event.content)
    next
  end
  command = event.content.gsub(/^p\!/, "")
  puts "command: #{command}"
  if $commands.key?(command)
    puts "found"
    event.respond(send(command))
  else
    puts "not found"
  end
end
puts "This bot's invite URL is #{puck.invite_url}."



puck.run
