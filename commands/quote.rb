$commands["quote"] = "Get a random quote, or add a quote with 'quote add'"
$puck.command :quote do |event, *args|
  if args[0] == "add"
    args.shift
    quote = args.join(' ')
    $db.execute("INSERT INTO quotes(author, quote, date)
    VALUES(?, ?, ?);", [event.user.name, quote, Time.now.to_i])
    "Quote added!"
  elsif args.empty?
    rows = $db.execute("SELECT count() from quotes;")
    count = rows[0][0]
    rand_row = rand(1..count)
    rows = $db.execute("SELECT author, quote, date FROM quotes WHERE id = ?", [rand_row])
    author = rows[0][0]
    quote = rows[0][1]
    date = Time.at(rows[0][2])
    "#{quote}\n
    Added by **#{author}** at #{date}"
  end
end
