class Ability
  include CanCan::Ability

  def initialize(user)
    if user.super_administrator?
      can :manage, :all
    end

    if user.administrator?
      can :manage, Property
      can :manage, RealEstate
      can [:show, :update], User, user: user
    end

    if user.real_estate_administrator?
      can :manage, Property, real_estate: user.real_estate
      can :manage, RealEstate, id: user.real_estate_id
      can :manage, User
    end

    if user.agent?
      can :manage, Property, user: user
      can [:show], RealEstate, id: user.real_estate_id
      can [:show, :update], User, user: user
    end
  end
end
