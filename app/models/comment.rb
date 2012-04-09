class Comment < ActiveRecord::Base
  attr_accessible :content, :ticket_id, :user_id

  belongs_to :ticket
  belongs_to :user

  validates :content, :ticket_id, :user_id, :presence => true

  after_create :send_creation_notification

  default_scope order("created_at DESC")

  protected
  def send_creation_notification
  		if self.user != self.ticket.contact
  			UserMailer.comment_creation(self, self.ticket.contact).deliver 
  		end

  		if self.user != self.ticket.assignee
  			UserMailer.comment_creation(self, self.ticket.assignee).deliver 
  		end
  end

end
