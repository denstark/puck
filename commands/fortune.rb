$commands["fortune"] = "Get a drop of wisdom"

$puck.command :fortune do |event|
  output = %x(fortune)
  event.channel.send_embed do |embed|
    embed.colour = 0xf7f972
    embed.description = output
  end
end
