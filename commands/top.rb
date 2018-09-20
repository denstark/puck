$commands["top"] = "See the top chat leaders!"

$puck.command :top do |event, *args|
  serverId = event.user.server.id
  serverName = event.user.server.name
  top = DB[:top]
  rows = top.where(server: serverId).reverse_order(:score).limit(10)
  num = 1
  output = ''
  rows.each { |user|
    output += "##{num}: #{user[:name]} - #{user[:score]}\n"
    num += 1
  }

  event.channel.send_embed do |embed|
    embed.title = ":chart_with_upwards_trend: **Top chatters for #{serverName}**"
    embed.colour = 0x42f4c2
    embed.description = output
  end
end
