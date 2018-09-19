$commands["dice"] = "Roll some dice. d6 by default, or roll any dice like 3d20"

$puck.command :dice do |event, *args|

  dice = args[0]
  if dice == nil
    dice = '1d6'
  else
    dice = args[0]
  end

  diceArray = dice.split(/d/)
  number = diceArray[0].to_i
  sides = diceArray[1].to_i
  if number == 0 || sides == 0
    event.channel.send_embed do |embed|
      embed.colour = 0xff0000
      embed.description = 'Please enter a valid dice string. e.g. 2d20'
    end
    return
  end

  if number > 20
    number = 20
  end
  rolls = Array.new

  until number == 0
    rolls.push(rand(1..sides))
    number -= 1
  end

  sum = 0
  list = '['
  rolls.each do |x|
    sum += x
  end

  list += rolls.join(', ')
  list += ']'
  desc= ":game_die: **Dice Roller!**\n"
  desc += "I rolled #{dice}. Here are the results:\n"
  desc += "#{list}\n"
  desc += "And the sum is: **#{sum}**"

  event.channel.send_embed do |embed|
    embed.colour = 0x094287
    embed.description = desc
  end

end