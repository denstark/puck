_prefix = 'p!'

$commands = {
  "goodshit" => "Good shit copypasta",
  "help" => "this help message",
  "xkcd" => "Get a random xkcd",
  "qwantz" => "Get a random dinosaurcomic",
}

def goodshit
  return "👌👀👌👀👌👀👌👀👌👀 good shit go౦ԁ sHit👌 thats ✔ some good👌👌shit right👌👌there👌👌👌 right✔there ✔✔if i do ƽaү so my self 💯 i say so 💯 thats what im talking about right there right there (chorus: ʳᶦᵍʰᵗ ᵗʰᵉʳᵉ) mMMMMᎷМ💯 👌👌 👌НO0ОଠOOOOOОଠଠOoooᵒᵒᵒᵒᵒᵒᵒᵒᵒ👌 👌👌 👌 💯 👌 👀 👀 👀 👌👌Good shit"
end

def help
  output = "```"
  $commands.each do |key, val|
    output += "p!#{key} - #{val}\n"
  end
  output += "```"
  return output

end

def xkcd
  maxXKCD = 1821
  num = rand(1..maxXKCD)
  return "https://xkcd.com/#{num}/"
end

def qwantz
  max = 3128
  num = rand(1..max)
  return "http://www.qwantz.com/index.php?comic=#{num}"
end
