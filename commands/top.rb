$commands["top"] = "See the top chat leaders!  Use 'p!top me' to see your own stats"

$puck.command :top do |event, *args|
  cmd = args[0]

  case cmd
  when 'me'
    serverId = event.user.server.id
    serverName = event.user.server.name
    me = find_user(event.user.name, event)

    event.channel.send_embed do |embed|
      embed.title = "**User info for #{me["name"]}**
      "
      embed.colour = 0x42f4c2
      embed.add_field(name: "rank", value: me["rank"], inline: true)
      embed.add_field(name: "score", value: me["score"], inline: true)
      embed.add_field(name: "last_seen", value: Time.at(me["last_seen"]), inline: true)
    end
  end
  
  if args.empty?
    serverId = event.user.server.id
    serverName = event.user.server.name
    top = DB[:top].where(server:serverId).reverse_order(:score)
    rows = top.where(server:serverId).reverse_order(:score).limit(25)
    num = 1
    output = ''

    me = find_user(event.user.name, event)
    puts me
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
end

def find_user(name, event)
  puts "event name #{name}"

  found_user = {"name" => name.downcase}
  rows = DB[:top].where(server:event.user.server.id).reverse_order(:score).limit(100)
  num = 0
  found = false # avoid duplicates
  rows.each { |user|
    num += 1
    if found_user["name"] == user[:name] && found == false
      found_user["rank"] = num
      found_user["score"] = user[:score]
      found_user["last_seen"] = user[:last_seen]
      found = true
    end
}
  return found_user
end