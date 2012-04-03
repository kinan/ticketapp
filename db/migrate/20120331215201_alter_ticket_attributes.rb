class AlterTicketAttributes < ActiveRecord::Migration
  def up
  	rename_column :tickets, :summary, :subject
  	rename_column :tickets, :details, :description
  end

  def down
  end
end
