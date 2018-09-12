require 'sqlite3'
require_relative 'config.rb'

db = SQLite3::Database.new QUOTES_DB

# Create the quotes table
rows = db.execute <<-SQL
  CREATE TABLE quotes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author TEXT NOT NULL,
  quote TEXT NOT NULL,
  date INTEGER NOT NULL
);
SQL
