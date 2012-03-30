module ApplicationHelper
	def priorities
		["Low", "Medium", "High"]
	end

	def statuses
		["Open", "Pending", "Closed"]
	end

	def display_date(input_date)
		input_date.strftime("%B %d, %Y")
		#return input_date.strftime("%d %B %Y at %I:%M%p")
	end
end
