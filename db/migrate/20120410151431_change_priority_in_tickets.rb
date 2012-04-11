class ChangePriorityInTickets < ActiveRecord::Migration
  def up
  	add_column :tickets, :priority_id, :integer
  	remove_column :tickets, :priority
  end

  def down
  	remove_column :tickets, :priority_id
  	add_column :tickets, :priority, :string
  end
end
