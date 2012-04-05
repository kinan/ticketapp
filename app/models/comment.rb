class Comment < ActiveRecord::Base
  attr_accessible :content, :ticket_id, :user_id

  belongs_to :ticket
  belongs_to :user

  validates :content, :ticket_id, :user_id, :presence => true

  default_scope order("created_at DESC")
end
