require_relative "../config/environment.rb"

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade)
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

  def self.create
  end

  def self.new_from_db(row)
  end

  def self.find_by_name
  end

  def update
    sql = "UPDATE songs SET name = ?, album = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.album, self.id)
  end


end
