def topUserExists?(params = {})
  name = params[:name]
  disc = params[:disc]
  server = params[:server]
  rows = $db.execute("SELECT score from top WHERE name = ? AND discriminator = ? AND server = ?;", [name, disc, server])
  if rows.empty?
    return false
  else
    return true
  end
end

def topAddScore(params = {})
  name = params[:name]
  disc = params[:disc]
  server = params[:server]
  score = params[:score]
  $db.execute("UPDATE top SET score = score + ? WHERE discriminator = ? AND name = ? AND server = ?;", [score, disc, name, server])
end

def topAddNewUser(params = {})
  name = params[:name]
  disc = params[:disc]
  server = params[:server]
  $db.execute("INSERT INTO top(name, discriminator, server, last_seen) VALUES(?, ?, ?, ?);", [name, disc, server, Time.now.to_i])
end
