$commands["time"] = "Get the current time in a city's timezone"

$puck.command :time do |event, *args|
 offset = nil
 if args.empty?
   event << "You have to supply a city or timezone identifier (https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)"
   return
 end
 cities = {
   "london" => "Europe/London",
   "seattle" => "America/Los_Angeles",
   "philadelphia" => "America/New_York",
   "boston" => "America/New_York",
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
