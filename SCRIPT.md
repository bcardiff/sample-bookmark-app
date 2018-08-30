# Mission: run basic app with repo

```
$ crystal init app bookmarks_app
```

```
# shard.yml
dependencies:
  sqlite3:
    github: crystal-lang/crystal-sqlite3
```

```
$ shards install
```

copy bmdb.cr as ./src/bmdb.cr

use usage sample in ./src/bookmarks_app.cr

```
$ crystal src/bookmarks_app.cr
```

# Explain crystal build vs crystal run

# Mission: run basic kemal app with plain home

```
# shard.yml
dependencies:
  sqlite3:
    github: crystal-lang/crystal-sqlite3
  kemal:
    github: kemalcr/kemal
```

```
$ shards install
```

create ./src/home.ecr

```
# ./src/bookmarks_app.cr

require "./bmdb"
require "kemal"

db = BMDB.new

get "/" do
  bookmarks = db.read_all
  render "./src/home.ecr"
end

Kemal.run
db.close
```

```
# ./src/home.ecr
<!DOCTYPE html>
<html>
  <body>
    <h1>BookmarksApp</h1>
    <ul>
      <%- bookmarks.each do |b| -%>
        <li>
          <a href="<%= b.url%>"><%= b.url %></a>
        </li>
      <%- end -%>
    </ul>
  </body>
</html>
```

# Mission: Add bookmark

```
      <li>
        <form action="/b" method="POST">
          <input type="text" name="url" />
          <button type="submit">add</button>
        </form>
      </li>
```

```
post "/b" do |env|
  url = env.params.body["url"]
  db.create Bookmark.new(url)

  env.redirect "/"
end
```

# Mission: Remove bookmark

```
        <li>
          <a href="<%= b.url%>"><%= b.url %></a>
          -
          <form action="/b/<%= b.id %>/destroy" method="POST">
            <button type="submit">remove</button>
          </form>
        </li>
```

```
post "/b/:id/destroy" do |env|
  id = env.params.url["id"].to_i64
  db.destroy id

  env.redirect "/"
end
```