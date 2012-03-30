class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :summary
      t.text :details
      t.integer :group_id
      t.string :priority
      t.string :status
      t.integer :contact_id
      t.integer :creator_id
      t.integer :assignee_id

      t.timestamps
    end
  end
end
