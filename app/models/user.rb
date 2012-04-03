class User < ActiveRecord::Base
	has_secure_password
	attr_accessible :email, :password, :password_confirmation, :name, :phone, :role, :note
	has_many :tickets, :class_name => "Ticket", :foreign_key => "contact_id"

	# Validations
	validates :email, :name, :role, :presence => true
	validates :password, :presence => true, :on => :create

	# Callbacks
	before_create { generate_token(:auth_token) }

	# Authorization roles
	ROLES = %w[customer admin]

	def open_tickets
		self.tickets.where(:closed_at => nil) 	
	end

	def send_password_reset
  		generate_token(:password_reset_token)
  		self.password_reset_sent_at = Time.zone.now
  		save!
  		UserMailer.password_reset(self).deliver
	end

	def is?(role)
		self.role == role.to_s
	end
	
	protected
	def generate_token(column)
  		begin
    		self[column] = SecureRandom.urlsafe_base64
  		end while User.exists?(column => self[column])
	end   
end
