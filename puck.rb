require 'discordrb'
require_relative 'commands.rb'

bot = Discordrb::Bot.new token: 'Mjk1OTkzMTYyMjAyMzQ5NTc4.C7rwyw.ceFMkK-7TBhTGf2jqpO9YqbcrwA', client_id: 295993162202349578


bot.message() do |event|
  puts event.content
  if $commands.key?(event.content)
    puts "found"
    event.respond($commands[event.content][:output])
  elsif event.content = "p!help" then
        
  else
    puts "not found"
  end
end



bot.run
