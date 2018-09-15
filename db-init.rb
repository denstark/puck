require 'sqlite3'
require_relative 'config.rb'

db = SQLite3::Database.new PUCK_DB

# Create the quotes table
rows = db.execute <<-SQL
  CREATE TABLE quotes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author TEXT NOT NULL,
  quote TEXT NOT NULL,
  date INTEGER NOT NULL
);
SQL

rows = db.execute <<-SQL
  CREATE TABLE top (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name text NOT NULL,
    discriminator text NOT NULL,
    server integer NOT NULL,
    score INTEGER NOT NULL DEFAULT 0,
    last_seen INTEGER NOT NULL DEFAULT 0
  );
SQL
