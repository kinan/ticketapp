class CreateTeamsUsers < ActiveRecord::Migration
  def change
  	create_table :teams_users do |t|
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
