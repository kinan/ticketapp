class AddClosedAtToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :closed_at, :datetime

  	add_index :tickets, :status
  	add_index :tickets, :priority
  	add_index :tickets, :contact_id
  	add_index :tickets, :creator_id
  	add_index :tickets, :assignee_id
  	add_index :tickets, :group_id
  end

  


end
