class AlterUserName < ActiveRecord::Migration
  def up
  	remove_column :users, :first_name
  	remove_column :users, :last_name
  	add_column :users, :name, :string
  	add_index :users, :name
  end

  def down
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	remove_column :users, :name
  	remove_index :users, :name
  end
end
