class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.administrator?
      can :access, :rails_admin
      can :manage, :all
    elsif user
      can %i(new edit create update destroy), ShoppingCart
      can %i(create destroy), ShoppingCartItem
    end
    can %i(read), Commodity
  end
end
