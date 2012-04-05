class User < ActiveRecord::Base
	has_secure_password
	attr_accessible :email, :password, :password_confirmation, :name, :phone, :role, :note, :team_ids
	has_many :tickets, :class_name => "Ticket", :foreign_key => "contact_id"
	has_many :comments

	has_and_belongs_to_many :teams

	# Validations
	validates :email, :name, :role, :presence => true
	validates :password, :presence => true, :on => :create

	# Callbacks
	after_initialize :init
	before_create { generate_token(:auth_token)}
	before_update {remove_teams if self.is? :customer}
	before_destroy :remove_teams
	

	scope :admins, where(:role => "admin")

	# Authorization roles
	ROLES = %w[customer admin]

	def init
     self.role  ||= "customer"   #will set the default role to customer
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

	def is?(role)
		self.role == role.to_s
	end
	
	protected
	def remove_teams
		self.teams.clear
	end
	def generate_token(column)
  		begin
    		self[column] = SecureRandom.urlsafe_base64
  		end while User.exists?(column => self[column])
	end   
end
