class ShoppingCartItemsController < ApplicationController
  authorize_resource only: %i(create destroy)

  def create
    shopping_cart = ShoppingCart.get_shopping_cart(current_user)
    @shopping_cart_item = shopping_cart.shopping_cart_items.build(commodity_id: params[:commodity_id])
    respond_to do |format|
      if @shopping_cart_item && @shopping_cart_item.save
        format.html { redirect_to edit_user_shopping_cart_path(current_user, current_user.shopping_cart), notice: 'Shopping cart item was successfully created.' }
      else
        format.html { redirect_to commodity, alert: 'Shopping cart item was error created.' }
      end
    end
  end

  def destroy
    current_user.shopping_cart.shopping_cart_items.find_by(commodity_id: params[:commodity_id]).destroy
    respond_to do |format|
      format.html { redirect_to edit_user_shopping_cart_path(current_user, current_user.shopping_cart), notice: 'Shopping cart item was successfully destroyed.' }
    end
  end
end
