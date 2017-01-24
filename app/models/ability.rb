class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
		can :manage, :all
		can :access, :ckeditor 
		can [:read, :create, :destroy], Ckeditor::Picture
		can [:read, :create, :destroy], Ckeditor::AttachmentFile
    else
      can :read, :all
    end
  end
end
