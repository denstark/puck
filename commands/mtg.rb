$commands["mtg"] = "Search for a Magic the Gathering card"
$puck.command :mtg do |event, *args|
  cmds = ['card']
  if (cmds.include?(args[0]))
    cmd = args.shift
  else
    cmd = ''
  end
  case cmd
  when 'card', ''
    cardName = args.join(" ")
    cards = MTG::Card.where(name: cardName).all
    printCard(event, cards[0])
  end
end
def printCard(event, card)
  description = ""
  description += "**#{card.name}** #{card.mana_cost}\n"
  if (card.power != nil && card.toughness != nil)
    description += "#{card.power}/#{card.toughness}\n"
  end
  if (card.loyalty != nil)
    description += "Loyalty: #{card.loyalty}\n"
  end
  description += "#{card.type} | #{card.set} | #{card.rarity}\n"
  description += "#{card.text}\n"
  if (card.flavor != nil)
    description += "*#{card.flavor}*\n"
  end

  event.channel.send_embed do |embed|
    embed.timestamp = Time.now
    embed.description = description
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: card.image_url)
  end
end
