class Ability
  include CanCan::Ability

  def initialize(user)

    if user.administrator?
      can :manage, Property
      can [:show, :update], User, user: user
    end
    
    if user.super_administrator?
      can :manage, :all
    end
  end
end
