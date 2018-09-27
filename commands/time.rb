$commands["time"] = "Get the current time in a city's timezone"

$puck.command :time do |event, *args|
 offset = nil
 if args.empty?
   event << "You have to put in a city"
   return
 end
 city = args[0]
 city = city.downcase
 puts city
 case city
 when "london"
   offset = "+01:00"
 when "seattle"
   offset = "-09:00"
 when "philadelphia", "philly", "boston"
   offset = "-04:00"
 else
   event << "Arguments are London, Philadelphia, Boston"
   return
 end
 "The time in #{city.capitalize} is " + Time.now.getlocal(offset).strftime("%a %I:%M%p").to_s
end
