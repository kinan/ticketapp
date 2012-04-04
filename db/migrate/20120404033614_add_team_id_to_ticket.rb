class AddTeamIdToTicket < ActiveRecord::Migration
  def change
  	add_column :tickets, :team_id, :integer
  end
end
