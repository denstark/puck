$commands["time"] = "Get the current time in a city's timezone"
$puck.command :time do |event, *args|
  TZ_NY = "America/New_York"
  TZ_LA = "America/Los_Angeles"
  offset = nil
  if args.empty?
    event << "You have to supply a city or timezone identifier (https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)"
    return
  end
  cities = {
    "london" => "Europe/London",
    "seattle" => TZ_LA,
    "philadelphia" => TZ_NY,
    "philly" => TZ_NY,
    "boston" => TZ_NY,
  }
  city = args[0]
  cityD = city.downcase
  idents = TZInfo::Timezone.all_identifiers
  if cities.key?(cityD)
    tz = TZInfo::Timezone.get(cities[cityD])
  elsif idents.include?(city)
    tz = TZInfo::Timezone.get(city)
  else
    event << "Incorrect city or timezone identifier"
    return
  end
  puts city
  "The time in #{tz.friendly_identifier} is " + tz.now.strftime("%a %I:%M%p").to_s
end
