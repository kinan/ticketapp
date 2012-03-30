class Ticket < ActiveRecord::Base
	belongs_to :category
	belongs_to :assignee, :class_name => 'User', :foreign_key => 'assignee_id'
	belongs_to :contact, :class_name => 'User', :foreign_key => 'contact_id'
	belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'

	# Callbacks
  	before_update :set_closed_at

	scope :open, where(:closed_at => nil)
	scope :closed, where(:closed_at => !nil)

	def open?
    	closed_at.nil?
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


	#has_many :comments, :dependent => :destroy
end
