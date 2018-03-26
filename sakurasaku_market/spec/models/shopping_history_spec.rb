require 'rails_helper'

RSpec.describe ShoppingHistory, type: :model do
  before do
    @user = User.create!(name: 'foo', email: 'foo@example.com', password: '123456', address: 'address')
    @delivery_date = ShoppingCart.get_delivery_date_list(Date.today).first
    @shopping_cart = @user.build_shopping_cart({delivery_date: @delivery_date, delivery_period_type: 1, payment_method_type: 1})
    @shopping_cart.save!
    @ichigo = Commodity.create!(name: 'いちご', price: 200, display_flag: true, display_index: 1)
    @sakuranbo = Commodity.create!(name: 'さくらんぼ', price: 500, display_flag: true, display_index: 2)
    @pain = Commodity.create!(name: 'パイナップル', price: 400, display_flag: false, display_index: 2)
  end

  describe "shopping_history" do
    it "get_params" do
      @shopping_cart.shopping_cart_items.build(commodity_id: @ichigo.id).save!
      @shopping_cart.shopping_cart_items.build(commodity_id: @sakuranbo.id).save!
      @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
      @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
      expect(@shopping_cart.get_shopping_cart_items_subtotal).to eq 1500

      params = ShoppingHistory.get_params(@shopping_cart)
      expect(params[:address]).to eq 'address'
      expect(params[:delivery_date].to_date).to eq @delivery_date
      expect(params[:delivery_period_type]).to eq "8-12"
      expect(params[:payment_method_type]).to eq "代引き"
      expect(params[:subtotal]).to eq 1500
      expect(params[:cash_on_delivery_commission]).to eq 300
      expect(params[:shipping_fee]).to eq 600
      expect(params[:tax_included_price]).to eq 2592
    end
    
    it "save_include_items_delete_cart 配送日なし" do
      shopping_history = @user.shopping_histories.build(ShoppingHistory.get_params(@shopping_cart))
      shopping_history.delivery_date = nil
      expect(shopping_history.save_include_items_delete_cart(@shopping_cart)).to eq false
      expect(@shopping_cart).to_not eq nil
    end

    it "save_include_items_delete_cart" do
      shopping_history = @user.shopping_histories.build(ShoppingHistory.get_params(@shopping_cart))
      @shopping_cart.shopping_cart_items.build(commodity_id: @ichigo.id).save!
      @shopping_cart.shopping_cart_items.build(commodity_id: @sakuranbo.id).save!
  
      expect(shopping_history.save_include_items_delete_cart(@shopping_cart)).to eq true
      expect{ ShoppingCart.find(@shopping_cart.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end  
end
