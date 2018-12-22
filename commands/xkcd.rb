$commands["xkcd"] = "Get a random xkcd comic"

$puck.command :xkcd do |event|
  XKCD_JSON_URL = 'https://xkcd.com/info.0.json'
  uri = URI(XKCD_JSON_URL)
  response = Net::HTTP.get(uri)
  dict = JSON.parse(response)
  maxXKCD = dict['num']
  num = rand(1..maxXKCD)
  "https://xkcd.com/#{num}/"
end
