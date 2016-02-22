require 'spec_helper.rb'
require 'pry'
# access the test database by typing TEST_DB[:conn]

describe User do
  let(:attributes) {{
    id: nil,
    name: "Sam",
    fav_movie_id: nil
  }}

  let(:new_user){User.new(attributes)}

  describe '.table_name' do 
    it 'creates a downcased, plural table name based on the Class name' do 
      expect(User.table_name).to eq('users')
    end
  end

  describe '.public_attributes' do 
    it 'returns an array of SQL column names' do 
      expect(User.public_attributes).to eq(["name".to_sym, "fav_movie_id".to_sym])
    end
  end
  describe 'initialize' do 
    it 'creates an new instance of a user' do 
      expect(new_user).to be_a User
    end
    it "assigns the user name when initialized" do 
      expect(new_user.name).to eq("Sam")
    end
  end
  describe 'attr_accessor' do 
    it 'creates attr_accessors for each column name' do 
      old_name = new_user.name
      new_name = new_user.name = "Jo"
      old_movie_id = new_user.fav_movie_id
      new_movie_id = new_user.fav_movie_id = 2
      expect(old_name).to eq("Sam")
      expect(new_name).to eq("Jo")
      expect(old_movie_id).to eq(nil)
      expect(new_movie_id).to eq(2)
    end
  end
  describe '#public_values' do 
    it 'formats the column names to be used in s SQL statement' do 
      expect(new_user.public_values).to eq(['Sam', nil])
    end
  end
  describe '#save' do 
    DB[:conn].execute("DROP TABLE IF EXISTS users")
    User.create_table
    it 'saves the user to the db' do 
      new_user.save
      # binding.pry
      expect(DB[:conn].execute("SELECT * FROM users WHERE name = 'Sam'")).to eq([[1, "Sam", nil]])
    end

    it 'sets the user\'s id' do
      new_user.save
      expect(new_user.id).to eq(2)
    end
  end
end


