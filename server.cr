require "kemal"
require "sqlite3"

db = DB.open "sqlite3://./data.db"
db.exec "CREATE TABLE IF NOT EXISTS messages (id INTEGER PRIMARY KEY, title text, body text)"

# db.exec "INSERT INTO messages (title, body) VALUES ($2,$3)", "hello world", "my body"

def get_messages(db)
  messages = [] of Tuple(Int32, String, String)

  db.query "select id, title, body from messages" do |rs|
    rs.each do
      id = rs.read(Int32)
      title = rs.read(String)
      message = rs.read(String)

      messages << {id, title, message}
    end
  end

  messages
end

get "/" do
  messages = get_messages(db)

  render "views/index.html.ecr", "views/layouts/layout.ecr"
end

get "/messages/:id/edit" do |env|
  id = env.params.url["id"].to_i

  id, title, message = db.query_one "select id, title, body from messages where id = $1 limit 1", id, as: {Int32, String, String}

  render "views/turbo-frame.html.ecr"
end

post "/messages/:id" do |env|
  id = env.params.url["id"].to_i
  title = env.params.body["message[name]"].as(String)
  message = env.params.body["message[message]"].as(String)

  db.exec "update messages set title = ?, body = ? where id = ?", title, message, id

  messages = get_messages(db)

  env.redirect "/", status_code: 303
end

get "/stream" do |env|
  env.response.content_type = "text/vnd.turbo-stream.html"
  render "views/turbo-stream.html.ecr"
end

get "/emails.html" do
  sleep 5
  render "views/emails.ecr"
end

at_exit { db.close() }
Kemal.run