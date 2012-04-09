module TicketsHelper
	def display_date(date)
		date.strftime("%B %d, %Y")
	end

	def display_date_time(date)
		date.strftime("%B %d, %Y at %I:%M%p")
	end

	def display_priority(priority)
		case priority
		when "low"
  		klass = "label label-inverse"
		when "medium"
			klass = "label label-warning"
  	when "high"
  		klass =  "label label-important"
		else
  		klass = "label"
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

	def active_link(scope, priority, status, id=nil)
		if !params["#{scope}_id"].nil? && params["#{scope}_id"] == id.to_s || 
				scope.nil? && id.nil? && params[:user_id].nil? && params[:team_id].nil?
			is_scope = true
		end

		if params[:priority] == priority
			is_priority = true
		end

		if params[:status] == status
			is_status = true
		end

		is_scope && is_priority && is_status ? 'active' : ''	
	end

end
