class ShoppingHistoriesController < ApplicationController
  authorize_resource only: %i(index show create destroy)
  before_action :set_shopping_history, only: [:show, :edit, :update, :destroy]

  def index
    @shopping_histories = current_user.shopping_histories
  end

  def show
  end

  def create
    @shopping_history = current_user.shopping_histories.build(ShoppingHistory.get_params(current_user.shopping_cart))

    respond_to do |format|
      if @shopping_history.save_include_items_delete_cart(current_user.shopping_cart)
        format.html { redirect_to new_user_shopping_cart_path(current_user), notice: 'Shopping history was successfully created.' }
      else
        format.html { redirect_to edit_user_shopping_cart_path(current_user, current_user.shopping_cart), notice: 'Shopping history was error created.' }
      end
    end
  end

  def destroy
    @shopping_history.destroy
    respond_to do |format|
      format.html { redirect_to user_shopping_histories_path, notice: 'Shopping history was successfully destroyed.' }
    end
  end

  private
    def set_shopping_history
      @shopping_history = current_user.shopping_histories.find(params[:id])
    end
end
