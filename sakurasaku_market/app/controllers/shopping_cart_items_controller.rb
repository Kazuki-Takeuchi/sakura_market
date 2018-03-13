class ShoppingCartItemsController < ApplicationController
  authorize_resource only: %i(create destroy)

  def create
    shopping_cart = current_user.shopping_cart
    commodity = Commodity.find(params[:commodity_id])
    if shopping_cart.nil?
      shopping_cart = current_user.build_shopping_cart
      unless shopping_cart.save
        format.html { redirect_to commodity, alert: 'Shopping cart item was error created.' }
      end
    end
    @shopping_cart_item = shopping_cart.build_shopping_cart_item(commodity_id: commodity.id)

    respond_to do |format|
      if @shopping_cart_item.save
        format.html { redirect_to edit_user_shopping_cart_path(current_user, current_user.shopping_cart), notice: 'Shopping cart item was successfully created.' }
      else
        format.html { redirect_to commodity, alert: 'Shopping cart item was error created.' }
      end
    end
  end

  def destroy
    current_user.shopping_cart.shopping_cart_items.find(params[:commodity_id]).destroy
    respond_to do |format|
      format.html { redirect_to shopping_cart_items_url, notice: 'Shopping cart item was successfully destroyed.' }
    end
  end
end
