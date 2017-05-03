$commands = {
  "goodshit" => "Good shit copypasta",
  "help" => "this help message",
  "xkcd" => "Get a random xkcd",
  "qwantz" => "Get a random dinosaurcomic",
  "fortune" => "Get a drop of wisdom",
  "quote" => "Get a quote or add a quote with 'quote add'",
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
  output
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
    open(QUOTES_FILE, 'a') do |f|
      f.puts quote
    end
    "Quote added!"
  elsif args.empty?
    chosen_quote = nil
    File.foreach(QUOTES_FILE).each_with_index do |line, number|
      chosen_quote = line if rand < 1.0/(number+1)
    end
    "#{chosen_quote}"
  end
end
