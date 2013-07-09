class Ability

  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:new, :create], Tshirt
    if user.has_role? :admin
      can :manage, :all
    end
    can :manage, Tshirt do |tshirt|
      tshirt.user == user
    end
  end
end
