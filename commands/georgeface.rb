$commands["georgeface"] = "It's George Costanza from Family Guy!"

$puck.command :georgeface do |event, *args|

  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://cdn.discordapp.com/attachments/84435142470270976/495715585854799873/1300044776986.jpg")
  end
end
