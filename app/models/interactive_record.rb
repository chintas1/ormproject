require_relative '../../config/environment.rb'
class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    self.class.column_names.reject {|col| col == "id"}.join(", ")
  end

  def values_for_insert
    col_names_for_insert.split(", ").collect do |var|
      val = self.send("#{var}")
      "'#{val}'"
    end.join(", ")
  end

  def self.column_names
    DB[:conn].results_as_hash = true
    table_info = DB[:conn].execute("pragma table_info('students')")
    columns = table_info.collect {|col_info| col_info["name"]}
  end

  self.column_names.each do |col_name|
    attr_accessor col_name.to_sym
  end

  def initialize(attrs = {})
    attrs.each do |attribute, value|
      self.send("#{attribute.downcase}=", value)
    end
  end

  def save
    sql = <<-SQL  
      INSERT INTO #{self.table_name_for_insert} (#{self.col_names_for_insert}) VALUES (#{self.values_for_insert})
    SQL
    DB[:conn].execute(sql)
    sql = <<-SQL  
      SELECT MAX(id) FROM #{self.table_name_for_insert}
    SQL
    self.id = DB[:conn].execute(sql)[0][0]
    self  
  end

  def self.find_by(search)
    sql = <<-SQL
      SELECT * FROM #{self.table_name} WHERE #{search.keys[0].to_s} = ?
    SQL
    DB[:conn].execute(sql, search.values[0])
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM #{self.table_name} WHERE name = ?
    SQL
    obj = DB[:conn].execute(sql, name)
  end
end