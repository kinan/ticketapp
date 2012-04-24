class UserMailer < ActionMailer::Base
  default from: ""

  def password_reset(user)
    @user = user
    mail :to => @user.email, :subject => "Your Password Instructions"
  end

  def ticket_confirmation(ticket)
  	@ticket = ticket
  	@user = ticket.contact
  	
  	mail :to => @user.email, :subject => "Your remedy ticket of \"#{@ticket.subject}\" is created"
  end

  def ticket_closure(ticket)
  	@ticket = ticket
  	@user = ticket.contact
  	
  	mail :to => @user.email, :subject => "Your remedy ticket of \"#{@ticket.subject}\" is closed"
  end

  def ticket_team_assignment(ticket)
  	@ticket = ticket
  	@team = ticket.team
    emails = []
    @team.users.each{|u| emails << u.email}
  	
  	mail :to => emails.join(", "), :subject => "New remedy ticket is assigned to your team"
  end

  def ticket_user_assignment(ticket)
  	@ticket = ticket
  	@user = ticket.assignee
  	
  	mail :to => @user.email, :subject => "New Ticket is assigned to you"
  end

  def comment_creation(comment, user)
  	@comment = comment
  	@user = comment.user

  	mail :to => @user.email, :subject => "#{@comment.user.name} commented on \"#{@comment.ticket.subject}\""
  end

end
