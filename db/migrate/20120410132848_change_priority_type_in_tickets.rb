class ChangePriorityTypeInTickets < ActiveRecord::Migration
  def up
  	change_column :tickets, :priority, :integer
  end

  def down
  	change_column :tickets, :priority, :string
  end
end
