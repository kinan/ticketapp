# See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :admin
      can :manage, :all
    elsif user.is? :customer
      # Ticket
      can :create, Ticket
      can [:read, :update], Ticket, :contact_id => user.id

      # User
      can [:show, :update], User, :id => user.id  
    else # guest
        # add things that a guest can do
    end

  end
end


