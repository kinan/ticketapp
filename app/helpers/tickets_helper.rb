module TicketsHelper
	def display_date(input_date)
		input_date.strftime("%B %d, %Y")
		#return input_date.strftime("%d %B %Y at %I:%M%p")
	end

	def display_priority(priority)
		case priority
		when "low"
  		klass = "label"
		when "medium"
			klass = "label label-warning"
  	when "high"
  		klass =  "label label-important"
		else
  		klass = "label label-info"
		end
		raw("<span class='#{klass}'>#{priority.humanize}</span>")
	end

	# Display Unassigned, if a user got deleted or unassigned tickets
	def display_user(user)
		user ? user.name : "Unassigned"
	end

	# Show Unassigned, if a team got deleted or unassigned tickets
	def display_team(team)
		team ? team.name : "Unassigned"
	end
end
