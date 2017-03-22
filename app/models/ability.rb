class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
  		can :manage, :all
  		can :access, :ckeditor
    else
      can :read, Article
    end

    if user.has_role? :editor
      can :update, Article
      can :access, :ckeditor
    end

    if user.has_role? :author
      can :create, Article
      can :manage, Article, :user_id => user.id
      can :access, :ckeditor
    end
  end
end
