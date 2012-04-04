class Team < ActiveRecord::Base
  attr_accessible :name, :user_ids

  has_and_belongs_to_many :users
  has_many :tickets

  # Validations
	validates :name, :users, :presence => true


  def open_tickets
		self.tickets.where(:closed_at => nil) 	
	end

end
