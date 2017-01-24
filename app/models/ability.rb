class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
      can :access, :ckeditor 
    else
      can :read, :all
    end
  end
end
