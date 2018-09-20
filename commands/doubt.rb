$commands["doubt"] = "Press X to express doubt."

$puck.command :doubt do |event, *args|

  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://cdn.discordapp.com/attachments/193255335253901312/492191251995820047/Doubt.jpg")
  end

end