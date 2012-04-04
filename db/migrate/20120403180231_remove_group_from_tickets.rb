class RemoveGroupFromTickets < ActiveRecord::Migration
  def up
  	remove_column :tickets, :group_id
  end

  def down
  	add_column :tickets, :group_id
  end
end
