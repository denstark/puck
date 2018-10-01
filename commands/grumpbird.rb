$commands["grumpy"] = "Grumpy Bird dot pee n gee"

$puck.command :grumpy do |event, *args|

  event.channel.send_embed do |embed|
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://cdn.discordapp.com/attachments/84435142470270976/433030169322717214/Grumpy_Bird.png")
  end
end
