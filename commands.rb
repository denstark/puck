$commands = {
  "goodshit" => "Good shit copypasta",
  "help" => "this help message",
  "xkcd" => "Get a random xkcd",
  "qwantz" => "Get a random dinosaurcomic",
  "fortune" => "Get a drop of wisdom",
  "quote" => "Get a quote or add a quote with 'quote add'",
  "trout" => "Slap someone with a trout",
  "coin" => "Get a coinflip",
  "8ball" => "Ask the magic 8 ball a question",
}

$puck.command :goodshit do |event|
  "👌👀👌👀👌👀👌👀👌👀 good shit go౦ԁ sHit👌 thats ✔ some good👌👌shit right👌👌there👌👌👌 right✔there ✔✔if i do ƽaү so my self 💯 i say so 💯 thats what im talking about right there right there (chorus: ʳᶦᵍʰᵗ ᵗʰᵉʳᵉ) mMMMMᎷМ💯 👌👌 👌НO0ОଠOOOOOОଠଠOoooᵒᵒᵒᵒᵒᵒᵒᵒᵒ👌 👌👌 👌 💯 👌 👀 👀 👀 👌👌Good shit"
end

$puck.command :help do |event|
  output = "```"
  $commands.each do |key, val|
    output += "p!#{key} - #{val}\n"
  end
  output += "```"
  event.user.pm(output)
  nil
end

$puck.command :'8ball' do |event|
  answers = [
    "It is certain.",
    "It is decidedly so.",
    "Without a doubt.",
    "Yes - definitely.",
    "You may rely on it.",
    "As I see it, yes.",
    "Most likely",
    "Outlook good.",
    "Yes.",
    "Signs point to yes.",
    "Reply hazy, try again",
    "Ask again later.",
    "Better not tell you now.",
    "Cannot predict now.",
    "Concentrate and ask again.",
    "Don't count on it.",
    "My reply is no.",
    "My sources say no.",
    "Outlook not so good.",
    "Very doubtful.",
  ]
  answers.sample
end

$puck.command :xkcd do |event|
  maxXKCD = 1821
  num = rand(1..maxXKCD)
  "https://xkcd.com/#{num}/"
end

$puck.command :qwantz do |event|
  max = 3128
  num = rand(1..max)
  "http://www.qwantz.com/index.php?comic=#{num}"
end

$puck.command :fortune do |event|
  output = "```"
  output += %x(fortune)
  output += "```"
  output
end

$puck.command :quote do |event, *args|
  if args[0] == "add"
    args.shift
    quote = args.join(' ')
    $db.execute("INSERT INTO quotes(author, quote, date)
    VALUES(?, ?, ?);", [event.user.name, quote, Time.now.to_i])
    "Quote added!"
  elsif args.empty?
    rows = $db.execute("SELECT count() from quotes;")
    count = rows[0][0]
    rand_row = rand(1..count)
    rows = $db.execute("SELECT author, quote, date FROM quotes WHERE id = ?", [rand_row])
    author = rows[0][0]
    quote = rows[0][1]
    date = Time.at(rows[0][2])
    "#{quote}\n
    Added by **#{author}** at #{date}"
  end
end

$puck.command :trout do |event, *args|
  "#{event.user.name} slaps #{args[0]} around with a large trout."
end

$puck.command :coin do |event|
  r = rand
  puts r
  coin = nil
  if r <= 0.5
    coin = "Heads"
  else
    coin = "Tails"
  end
  "**#{event.user.name}** flipped a coin and it landed **#{coin.upcase}**"
end

$puck.command :timeat do |event, *args|
 offset = nil
 if args.empty?
   event << "You have to put in a city"
   return
 end
 city = args[0]
 city.downcase
 case city
 when "london"
   offset = "+00:00"
 when "seattle"
   offset = "-09:00"
 when "philadelphia"
   offset = "-04:00"
 when "philly"
   offset = "-04:00"
 when "boston"
   offset = "-04:00"
 else
   event << "Arguments are London, Philadelphia, Boston"
   return
 end
 "The time in #{city.capitalize} is " + Time.now.getlocal(offset).strftime("%a %I:%M%p").to_s
end
