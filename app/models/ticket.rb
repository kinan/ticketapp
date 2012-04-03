class Ticket < ActiveRecord::Base
	belongs_to :category
	belongs_to :assignee, :class_name => 'User', :foreign_key => 'assignee_id'
	belongs_to :contact, :class_name => 'User', :foreign_key => 'contact_id'
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'

	# Callbacks
  before_update :set_closed_at
  before_create :open_ticket

  default_scope order("created_at DESC")
	scope :open, where(:closed_at => nil)
	scope :closed, where(:closed_at => !nil)
  

  # Priorites
  PRIORITIES = ["low", "medium", "high"]

  # Statuses
  STATUSES = ["open", "pending", "closed"]
	
  def open?
    closed_at.nil?
  end

  def status?(status)
    self.status.include? status.to_s
  end

  def priority?(priority)
    self.priority.include? priority.to_s
  end

  protected
  def set_closed_at
    # update the closed_at timestamp if the ticket is being closed
    if closed?
      self.closed_at = DateTime.now if self.closed_at.nil?
    else
      self.closed_at = nil unless self.closed_at.nil?
    end
  end

  def open_ticket
    self.status = "open"   
  end


	#has_many :comments, :dependent => :destroy
end
