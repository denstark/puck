$commands["doubt"] = "Press X to express doubt."

$puck.command :doubt do |event, *args|
  event.channel.send_embed do |embed|
    if Time.now.month == 10
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://cdn.discordapp.com/attachments/84493464808480768/496290515927564297/Doot.PNG")
    else
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://cdn.discordapp.com/attachments/84435142470270976/492193424351559715/Doubt.png")
    end
  end
end
