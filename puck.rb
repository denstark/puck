require 'discordrb'
require_relative 'commands.rb'

puck = Discordrb::Bot.new token: 'MzA5MDE1OTI1OTAwNzA1Nzky.C-pRDA.m4-yZozL1C2nPaCFeEG1XNtlJMY', client_id: 309015925900705792


puck.message() do |event|
  puts "#{event.user.name}: #{event.content}"
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
