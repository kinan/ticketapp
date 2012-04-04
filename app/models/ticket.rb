class Ticket < ActiveRecord::Base
	belongs_to :category
	belongs_to :assignee, :class_name => 'User', :foreign_key => 'assignee_id'
	belongs_to :contact, :class_name => 'User', :foreign_key => 'contact_id'
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :team

  validates :subject, :description, :team_id, :presence => true

	# Callbacks
  before_update :set_closed_at
  after_initialize :init

  default_scope order("created_at DESC")
	scope :open, where(:closed_at => nil)
	scope :closed, where(:closed_at => !nil)
  

  # Priorites
  PRIORITIES = ["low", "medium", "high"]

  # Statuses
  STATUSES = ["open", "pending", "closed"]
	
  def init
     self.status  ||= "open"   #will set the default role to customer
  end

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
    if !open?
      self.closed_at = DateTime.now if self.closed_at.nil?
    else
      self.closed_at = nil unless self.closed_at.nil?
    end
  end

	#has_many :comments, :dependent => :destroy
end
