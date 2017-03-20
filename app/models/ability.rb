class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
		can :manage, :all
		can :access, :ckeditor 
		can :manage, :contacts
    else
      can :read, :all
    end
  end
end
