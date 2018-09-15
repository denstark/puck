class PuckDB

  def initialize(params = {})
    @dbconn = SQLite3::Database.new params[:dbpath]
  end

  def dbconn
    @dbconn
  end
end
