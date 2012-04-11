class AddAdminUser < ActiveRecord::Migration
  def up
  	User.create :name => "admin", :email => "admin@example.com", :password => "test123", :role => "admin"
  end

  def down
  end
end
