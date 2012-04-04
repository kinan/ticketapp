jQuery ->
	$(document).ready(show_hide_teams())
	$("#user_role_admin").click ->
		$("#teams").show("slow")
	$("#user_role_customer").click ->
		$("#teams").hide("slow")


show_hide_teams = () ->
	if $('input:radio[name=user[role]]:checked').val() == "admin"
		$("#teams").show()





		