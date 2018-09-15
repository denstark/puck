$commands["top"] = "See the top chat leaders!"

$puck.command :top do |event, *args|
  serverId = event.user.server.id
  serverName = event.user.server.name
  topSQL = <<-SQL
SELECT name, score FROM top WHERE server = ? ORDER BY score DESC LIMIT 10;
SQL
  rows = $db.execute(topSQL, [serverId])
  output = ":bangbang: **Top chatters for #{serverName}**"
  output += '```'
  num = 1
  rows.each { |user|
    output += "##{num}: #{user[0]} - #{user[1]}\n"
    num += 1
  }
  output += '```'
  output
end
