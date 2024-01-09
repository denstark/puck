$commands["top"] = "See the top chat leaders!"




$puck.command :top do |event, *args|
  serverId = event.user.server.id
  serverName = event.user.server.name
  top = DB[:top].where(server:serverId).reverse_order(:score)
  rows = top.where(server:serverId).reverse_order(:score).limit(10)
  num = 1
  output = ''

  me = my_rank(event)
  
  rows.each { |user|
  output += "##{num}: #{user[:name]} - #{user[:score]}\n"
  num += 1
  }
  event.channel.send_embed do |embed|
    embed.title = "
    :chart_with_upwards_trend: **Top chatters for #{serverName}**
    
    ~##{me["rank"]}: #{me["name"]} - #{me["score"]}~
    "

    embed.colour = 0x42f4c2
    embed.description = output
  end
end

def my_rank(event)
  me = {"name" => event.user.name}
  rows = DB[:top].where(server:event.user.server.id).reverse_order(:score).limit(100)
  num = 0
  rows.each { |user|
    num += 1
    if user[:name] == event.user.name
      me["rank"] = num
      me["score"] = user[:score]
    end
}
  return me
end