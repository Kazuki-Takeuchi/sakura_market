class ShoppingCartsController < ApplicationController
  authorize_resource only: %i(new edit create update)
  before_action :set_shopping_cart, only: [:edit, :update]

  def new
    @shopping_cart = current_user.build_shopping_cart
  end

  def edit
  end

  def create
    @shopping_cart = current_user.build_shopping_cart(shopping_cart_params)

    respond_to do |format|
      if @shopping_cart.save
        format.html { redirect_to edit_user_shopping_cart_path(current_user, current_user.shopping_cart), notice: 'Shopping cart was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @shopping_cart.update(shopping_cart_params)
        format.html { redirect_to edit_user_shopping_cart_path(current_user, current_user.shopping_cart), notice: 'Shopping cart was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_shopping_cart
      @shopping_cart = current_user.shopping_cart
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shopping_cart_params
      params.require(:shopping_cart).permit(:payment_method_type, :delivery_date, :delivery_period_type)
    end
end
