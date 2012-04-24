class Ticket < ActiveRecord::Base
  belongs_to :category
  belongs_to :assignee, :class_name => 'User', :foreign_key => 'assignee_id'
  belongs_to :contact, :class_name => 'User', :foreign_key => 'contact_id'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :team
  belongs_to :priority
  has_many :comments, :dependent => :destroy

  has_attached_file :attachment

  #validates :subject, :description, :team_id, :contact_id, :presence => true

  # Callbacks
  before_update :set_closed_at, :send_assignment_notification
  after_initialize :init
  after_create :send_creation_notification

  default_scope order("created_at DESC")
  # This is a temporary solution
  #default_scope where(:closed_at => nil) # default is to show open tickets only
  scope :open, where(:closed_at => nil)
  scope :closed, where(:closed_at => !nil)
  

  # Statuses
  STATUSES = ["open", "pending", "closed"]
  
  def init
     self.status  ||= "open"   #will set the default role to customer
     self.priority ||= Priority.find_by_name "low"
  end

  def self.with_priority(priority)
    Priority.find_by_name(priority).tickets.open
  end

  def self.open
    where(:closed_at => nil)
  end

  def self.closed
    where(:status => "closed")
  end

  def due_date
    self.created_at + (self.priority.days).days
  end

  def open?
    closed_at.nil?
  end

  def self.receive_mail(message)
    contact = User.find_by_email message.from.first

    # Default team
    team_id = 5
    if contact
     ticket = Ticket.new :subject => message.subject, :description => message.body.decoded, 
        :contact_id => contact.id, :creator_id => contact.id, :team_id => team_id
     ticket.save

    end
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
