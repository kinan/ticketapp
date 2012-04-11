module TicketsHelper
	def display_date(date)
		date.strftime("%B %d, %Y")
	end

	def display_date_time(date)
		date.strftime("%B %d, %Y at %I:%M%p")
	end


	def display_due(ticket)
		due_in_days = (ticket.due_date - Time.now)/(3600 * 24)
		if ticket.open?
			if due_in_days < 0
				klass =  "label label-important"
			elsif due_in_days < 3
				klass = "label label-warning"
			elsif due_in_days
				klass = "label label-success"
			end
		else
			klass = "label label-inverse"
		end
		raw("<span class='#{klass}'>#{distance_of_time_in_words_to_now ticket.due_date}</span>")
  end

	# Display Unassigned, if a user got deleted or unassigned tickets
	def display_user(user)
		user ? user.name : "Unassigned"
	end

	# Show Unassigned, if a team got deleted or unassigned tickets
	def display_team(team)
		team ? team.name : "Unassigned"
	end

	def active_link(scope, status, id=nil)
		if !params["#{scope}_id"].nil? && params["#{scope}_id"] == id.to_s || 
				scope.nil? && id.nil? && params[:user_id].nil? && params[:team_id].nil?
			is_scope = true
		end

		if params[:status] == status
			is_status = true
		end

		is_scope && is_status ? 'active' : ''	
	end

end
