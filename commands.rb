$commands = Hash.new
require_all "commands/*.rb"

$puck.command :help do |event|
  output = "```"
  $commands.each do |key, val|
    output += "p!#{key} - #{val}\n"
  end
  output += "```"
  event.user.pm(output)
  nil
end
