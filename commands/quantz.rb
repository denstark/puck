$commands["quantz"] = "Get a random dinosaur comic"

$puck.command :qwantz do |event|
  max = 3128
  num = rand(1..max)
  "http://www.qwantz.com/index.php?comic=#{num}"
end
