$commands["quote"] = "Get a random quote, or add a quote with 'quote add'"
quotes = DB[:quotes]
$puck.command :quote do |event, *args|
  if args[0] == "add"
    args.shift
    quote = args.join(' ')
    quotes.insert(author: event.user.name, quote: quote, date: Time.now.to_i)
    "Quote added!"
  elsif args.empty?
    quote = quotes.order(Sequel.lit('RANDOM()')).first
    puts quote.inspect
    author = quote[:author]
    quotetext = quote[:quote]
    date = quote[:date]
    "#{quotetext}\n
    Added by **#{author}** at #{date}"
  end
end
