$commands["weather"] = "Get the weather for a given city"

$puck.command :weather do |event, *args|
  city = args.join(' ')
  search = Geocoder.search(city)
  if search.empty?
    puts "Error: not found"
    event.channel.send_embed do |embed|
      embed.colour = 0xff0000
      embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "Error")
      embed.timestamp = Time.at(Time.now)
      embed.description = "#{city} not found."
    end
    return
  end
  coords = search.first.coordinates
  url = "https://api.darksky.net/forecast/#{DARKSKY_API_KEY}/#{coords[0]},#{coords[1]}"
  puts "Pulling: #{url}"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  forecast = JSON.parse(response)
  currently = forecast['currently']
  daily = forecast['daily']
  temp = currently['temperature'].to_i
  hourly = forecast['hourly']
  summary = currently['summary']
  hourlySummary = hourly['summary']
  icons = {
      'clear-day' => ':sunny:',
      'clear-night' => ':night_with_stars:',
      'rain' => ':cloud_rain:',
      'snow' => ':cloud_snow:',
      'sleet' => ':cloud_rain:',
      'wind' =>  ':dash:',
      'fog' => ':foggy:',
      'cloudy' => ':cloud:',
      'partly-cloudy-day' => ':white_sun_cloud:',
      'partly-cloudy-night' => ':cloud:',
  }
  icon = icons[currently['icon']]


  colour = nil

  case temp
  when  80..500
    colour = 0xFE2416
  when 65..79
    colour = 0x16FE27
  when 40..64
    colour = 0x16DBFE
  when -500..40
    colour = 0xA1B0F4
  end

  desc = ":thermometer: #{temp}°F #{icon} #{summary}\n\n"
  desc += "**Today's Forecast**\n"
  desc += hourlySummary
  event.channel.send_embed do |embed|
    embed.colour = colour
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: city)
    embed.timestamp = Time.at(Time.now)
    embed.description = desc
  end
end
