$commands["xkcd"] = "Get a random xkcd comic"

$puck.command :xkcd do |event|
  maxXKCD = 1821
  num = rand(1..maxXKCD)
  "https://xkcd.com/#{num}/"
end
