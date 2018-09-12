$commands["coin"] = "Get a coinflip"

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
