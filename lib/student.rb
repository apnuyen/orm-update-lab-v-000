require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade, :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade, id=nil)
  end

  def self.create_table
  end

  def self.drop_table
  end

  def save
  	if self.id
  		self.update
  	else
  		sql = <<-SQL
  			INSERT INTO students (name, grade)
  			VALUES (?, ?)
      	SQL
  		DB[:conn].execute(sql, self.name, self.grade)
  		@id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  	end
  end

  def self.create(name:, grade:)
    song = Song.new(name, album)
    song.save
    song
  end

  def self.new_from_db(row)
    new_song = self.new  # self.new is the same as running Song.new
    new_song.id = row[0]
    new_song.name =  row[1]
    new_song.length = row[2]
    new_song
  end

  def self.find_by_name
    sql = <<-SQL
      SELECT *
      FROM songs
      WHERE name = ?
      LIMIT 1
    SQL

    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end

  def update
    sql = "UPDATE songs SET name = ?, album = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.album, self.id)
  end


end
