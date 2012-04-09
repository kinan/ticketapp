class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
  end
  User.create :name => "admin", :email => "admin@example.com", :password => "test123", :role => "admin"
end
