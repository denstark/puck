$commands["fortune"] = "Get a drop of wisdom"

$puck.command :fortune do |event|
  output = "```"
  output += %x(fortune)
  output += "```"
  output
end
