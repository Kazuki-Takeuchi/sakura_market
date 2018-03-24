module ShoppingCartsHelper
  def can_buy?
    @shopping_cart.id && current_user.address && @shopping_cart.delivery_date
  end

  def has_shopping_item?
    !@shopping_cart.shopping_cart_items.empty?
  end
end
