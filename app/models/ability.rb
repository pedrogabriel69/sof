class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment, Attachment]
    can [:update, :destroy], [Question, Answer], user: user


    can :destroy, Attachment do |object|
      user.author?(object.attachmentable)
    end

    can [:like, :unlike], [Question, Answer] do |object|
      !user.author?(object)
    end

    can :best, Answer do |object|
      user.author?(object.question)
    end
  end
end
