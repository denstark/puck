$commands["quote"] = "Get a random quote, or add a quote with 'quote add'"
quotes = DB[:quotes]
$puck.command :quote do |event, *args|
  cmd = args[0]
  output = String.new
  case cmd
  when 'add'
    args.shift
    quote = args.join(' ')
    qid = quotes.insert(author: event.user.name, quote: quote, server: event.user.server.id, date: Time.now.to_i)
    printQuote(event, quotes.first(:id => qid))
  when 'search'
    args.shift
    searchTerms = args.join(' ')
    searchTerms = "%#{searchTerms}%"
    quotes.where(server: event.user.server.id).where(Sequel.ilike(:quote, searchTerms)).limit(5).all do |quote|
      printQuote(event, quote)
    end
  when 'id', 'id:'
    args.shift
    id = args[0]
    quote = quotes.where(server: event.user.server.id).where(id: id).first
    if quote != nil
      printQuote(event, quote)
    elsif quote == nil
      output += "Quote not found!"
    end
  end
  if args.empty?
    quote = quotes.where(server: event.user.server.id).order(Sequel.lit('RANDOM()')).first
    printQuote(event, quote)
  end
  output
end

def printQuote(event, quote)
  event.channel.send_embed do |embed|
    embed.colour = 0x7efd91
    embed.timestamp = Time.at(quote[:date])
    embed.description = quote[:quote]
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "added by: #{quote[:author]} | id: #{quote[:id]}")
  end
end