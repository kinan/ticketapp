class Ticket < ActiveRecord::Base
  belongs_to :category
  belongs_to :assignee, :class_name => 'User', :foreign_key => 'assignee_id'
  belongs_to :contact, :class_name => 'User', :foreign_key => 'contact_id'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :team
  has_many :comments, :dependent => :destroy

  validates :subject, :description, :team_id, :contact_id, :presence => true

  # Callbacks
  before_update :set_closed_at, :send_assignment_notification
  after_initialize :init
  after_create :send_creation_notification

  default_scope order("created_at DESC")
  # This is a temporary solution
  #default_scope where(:closed_at => nil) # default is to show open tickets only
  scope :open, where(:closed_at => nil)
  scope :closed, where(:closed_at => !nil)
  

  # Priorites
  PRIORITIES = ["low", "medium", "high"]

  # Statuses
  STATUSES = ["open", "pending", "closed"]
  
  def init
     self.status  ||= "open"   #will set the default role to customer
  end

  def self.with_priority(priority)
    where(:priority => priority)
  end

  def self.open
    where(:closed_at => nil)
  end

  def self.closed
    where(:status => "closed")
  end


  protected
  def set_closed_at
    # update the closed_at timestamp if the ticket is being closed
    if self.status == "closed"
      self.closed_at = DateTime.now if self.closed_at.nil?
      UserMailer.ticket_closure(self).deliver
    else
      self.closed_at = nil unless self.closed_at.nil?
    end
  end

  def send_creation_notification
    UserMailer.ticket_confirmation(self).deliver
    UserMailer.ticket_team_assignment(self).deliver
  end

  def send_assignment_notification
    # Notify assignee
    if self.assignee && self.assignee != Ticket.find(self.id).assignee
      UserMailer.ticket_user_assignment(self).deliver
    end
    # Notify team
    if self.team != Ticket.find(self.id).team
      UserMailer.ticket_team_assignment(self).deliver
    end
  end

end
