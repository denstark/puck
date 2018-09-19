$commands["urban"] = "Get a definition for a word from urban dictionary."

$puck.command :urban do |event, *args|
  word = args.join(' ')
  url = "https://api.urbandictionary.com/v0/define?term=#{word}"
  puts "Pulling: #{url}"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  dict = JSON.parse(response)
  if dict['list'].empty?
    event.channel.send_embed do |embed|
      embed.colour = 0xff0000
      embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Error")
      embed.timestamp = Time.at(Time.now)
      embed.description = "#{word} not found."
    end
    return
  end
  bracketRegex = /[\[\]]/
  entry = dict['list'][0]
  definition = entry['definition'].gsub(bracketRegex, '')
  permalink = entry['permalink']
  thumbsUp = entry['thumbs_up']
  thumbsDown = entry['thumbs_down']
  example = entry['example'].gsub(bracketRegex, '')
  word = entry['word']
  desc = "#{definition}\n\n"
  desc += "**Example**\n"
  desc += "#{example}\n\n"
  desc += "**Thumbs**\n"
  desc += ":thumbsup:#{thumbsUp} | :thumbsdown: #{thumbsDown}\n\n"
  desc += "**Link**\n"
  desc += "#{permalink}\n"

  event.channel.send_embed do |embed|
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: word)
    embed.colour = 0xB32FD6
    embed.description = desc
  end
end