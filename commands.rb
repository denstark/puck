$commands = Hash.new
require_all "commands/*.rb"

logger = Logger.new(STDOUT)
logger.level = Logger::WARN

$puck.command :help do |event|
  output = "```"
  $commands.each do |key, val|
    output += "p!#{key} - #{val}\n"
  end
  output += "```"
  event.user.pm(output)
  logger.info "User-input: #{output}" 
  nil
end
