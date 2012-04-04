module UsersHelper
	def display_team_names(team)
		names = []
		team.each{|u| names << u.name}
		names.join(", ")
	end
end
