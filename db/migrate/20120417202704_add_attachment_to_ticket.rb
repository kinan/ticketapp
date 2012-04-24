class AddAttachmentToTicket < ActiveRecord::Migration
  def self.up
    change_table :tickets do |t|
      t.has_attached_file :attachment
    end
  end

  def self.down
    drop_attached_file :tickets, :attachment
  end
end
