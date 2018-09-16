def topAddScore(params = {})
  name = params[:name]
  disc = params[:disc]
  server = params[:server]
  score = params[:score]
  top = DB[:top]
  top.where(name: name, discriminator: disc, server: server).update(score: Sequel[:score] + score)
end

def topAddNewUser(params = {})
  name = params[:name]
  disc = params[:disc]
  server = params[:server]
  top = DB[:top]
  top.insert(name: name, discriminator: disc, server: server, last_seen: Time.now.to_i)
end
