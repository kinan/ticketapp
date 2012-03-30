class User < ActiveRecord::Base
	has_secure_password
	attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :phone
	has_many :tickets, :class_name => "Ticket", :foreign_key => "contact_id"

	# Validations
	validates_uniqueness_of :email, :first_name, :last_name
	validates_presence_of :password, :on => :create

	# Callbacks
	before_create { generate_token(:auth_token) }

	def full_name
		self.first_name + " " + self.last_name
	end

	def open_tickets
		self.tickets.where(:closed_at => nil) 	
	end

	def send_password_reset
  		generate_token(:password_reset_token)
  		self.password_reset_sent_at = Time.zone.now
  		save!
  		UserMailer.password_reset(self).deliver
	end
	
	protected
	def generate_token(column)
  		begin
    		self[column] = SecureRandom.urlsafe_base64
  		end while User.exists?(column => self[column])
	end   
end
