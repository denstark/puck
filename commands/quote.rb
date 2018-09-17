$commands["quote"] = "Get a random quote, or add a quote with 'quote add'"
quotes = DB[:quotes]
$puck.command :quote do |event, *args|
  cmd = args[0]
  output = String.new
  case cmd
  when 'add'
    args.shift
    quote = args.join(' ')
    quotes.insert(author: event.user.name, quote: quote, date: Time.now.to_i)
    output = "Quote added!"
  when 'search'
    args.shift
    searchTerms = args.join(' ')
    searchTerms = "%#{searchTerms}%"
    quotes.where(Sequel.ilike(:quote, searchTerms)).limit(5).all do |quote|
      output += printQuote(quote)
    end
  when 'id', 'id:'
    args.shift
    id = args[0]
    quote = quotes.where(id: id).first
    if quote != nil
      output = printQuote(quote)
    elsif quote == nil
      output += "Quote not found!"
    end
  end
  if args.empty?
    quote = quotes.order(Sequel.lit('RANDOM()')).first
    output = printQuote(quote)
  end
  output
end

def printQuote(quote)
  out = ''
  out += "#{quote[:quote]}\n\n"
  out += "**id:** #{quote[:id]}\n"
  out += "**Author:** #{quote[:author]}\n"
  out += "**Date:** #{Time.at(quote[:date]).strftime("%B %e, %Y at %H:%M")}\n"
  out += "\n"
  return out
end