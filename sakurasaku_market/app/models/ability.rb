class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.administrator?
      can :access, :rails_admin
      can :manage, :all
    else
      can %i(read), Commodity
    end
  end
end
