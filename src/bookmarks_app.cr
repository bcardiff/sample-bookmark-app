require "./bmdb"
require "kemal"

db = BMDB.new

get "/" do
  bookmarks = db.read_all
  render "./src/home.ecr"
end

post "/b" do |env|
  url = env.params.body["url"]
  db.create Bookmark.new(url)

  env.redirect "/"
end

post "/b/:id/destroy" do |env|
  id = env.params.url["id"].to_i64
  db.destroy id

  env.redirect "/"
end

Kemal.run
db.close
