module UsersHelper
	def display_user_names(users)
		names = []
		users.each{|u| names << u.name}
		names.join(", ")
	end

	def display_typehead(users)
		names = []
		users.each{|u| names << "\"#{u.name}\""}
		names.join(", ")
	end
end
