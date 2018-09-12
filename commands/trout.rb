$commands["trout"] = "Slap someone with a trout"

$puck.command :trout do |event, *args|
  "#{event.user.name} slaps #{args[0]} around with a large trout."
end
