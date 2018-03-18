require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  describe "get_delivery_date_list" do
    it "2018/3/16 の指定可能配送日取得" do    
      delivery_date_list = ShoppingCart.get_delivery_date_list(Date.new(2018, 3,16))
      expect(delivery_date_list.count).to eq 12
      expect(delivery_date_list[0]).to eq Date.new(2018, 3,21)
      expect(delivery_date_list[1]).to eq Date.new(2018, 3,22)
      expect(delivery_date_list[2]).to eq Date.new(2018, 3,23)
      expect(delivery_date_list[3]).to eq Date.new(2018, 3,26)
      expect(delivery_date_list[4]).to eq Date.new(2018, 3,27)
      expect(delivery_date_list[5]).to eq Date.new(2018, 3,28)
      expect(delivery_date_list[6]).to eq Date.new(2018, 3,29)
      expect(delivery_date_list[7]).to eq Date.new(2018, 3,30)
      expect(delivery_date_list[8]).to eq Date.new(2018, 4,2)
      expect(delivery_date_list[9]).to eq Date.new(2018, 4,3)
      expect(delivery_date_list[10]).to eq Date.new(2018, 4,4)
      expect(delivery_date_list[11]).to eq Date.new(2018, 4,5)
    end
  end

  describe "get_cash_on_delivery_commission" do
    it "0-10,000円未満" do
      expect(ShoppingCart.get_cash_on_delivery_commission(0)).to eq 0
      expect(ShoppingCart.get_cash_on_delivery_commission(1)).to eq 300
      expect(ShoppingCart.get_cash_on_delivery_commission(9999)).to eq 300
    end
    it "10,000-30,000円未満" do
      expect(ShoppingCart.get_cash_on_delivery_commission(10000)).to eq 400
      expect(ShoppingCart.get_cash_on_delivery_commission(29999)).to eq 400
    end
    it "30,000-100,000円未満" do
      expect(ShoppingCart.get_cash_on_delivery_commission(30000)).to eq 600
      expect(ShoppingCart.get_cash_on_delivery_commission(99999)).to eq 600
    end
    it "100,000円以上" do
      expect(ShoppingCart.get_cash_on_delivery_commission(100000)).to eq 1000
      expect(ShoppingCart.get_cash_on_delivery_commission(9999999)).to eq 1000
    end
  end

  describe "get_tax_included_price" do
    it "消費税" do
      expect(ShoppingCart.get_tax_included_price(0)).to eq 0
      expect(ShoppingCart.get_tax_included_price(97)).to eq 104 
      expect(ShoppingCart.get_tax_included_price(98)).to eq 105 
      expect(ShoppingCart.get_tax_included_price(99)).to eq 106 
      expect(ShoppingCart.get_tax_included_price(100)).to eq 108 
    end
  end
  
  describe "shopping_cart_items" do
    before do
      user = User.create!(name: 'foo', email: 'foo@example.com', password: '123456')
      @shopping_cart = user.build_shopping_cart
      @shopping_cart.save!
      @ichigo = Commodity.create!(name: 'いちご', price: 200, display_flag: true, display_index: 1)
      @sakuranbo = Commodity.create!(name: 'さくらんぼ', price: 500, display_flag: true, display_index: 2)
      @pain = Commodity.create!(name: 'パイナップル', price: 400, display_flag: false, display_index: 2)
    end

    describe "get_shopping_cart_items_subtotal" do
      it "小計" do
        @shopping_cart.shopping_cart_items.build(commodity_id: @ichigo.id).save!
        expect(@shopping_cart.get_shopping_cart_items_subtotal).to eq 200
        @shopping_cart.shopping_cart_items.build(commodity_id: @sakuranbo.id).save!
        expect(@shopping_cart.get_shopping_cart_items_subtotal).to eq 700
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        expect(@shopping_cart.get_shopping_cart_items_subtotal).to eq 1100
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        expect(@shopping_cart.get_shopping_cart_items_subtotal).to eq 1500
      end
    end
    
    describe "get_shipping_fee" do
      it "1パッケージ(5個まで)" do
        @shopping_cart.shopping_cart_items.build(commodity_id: @ichigo.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @sakuranbo.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        expect(@shopping_cart.get_shipping_fee).to eq 600
      end

      it "1パッケージ(6個以上)" do
        @shopping_cart.shopping_cart_items.build(commodity_id: @ichigo.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @sakuranbo.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        @shopping_cart.shopping_cart_items.build(commodity_id: @pain.id).save!
        expect(@shopping_cart.get_shipping_fee).to eq 1200
      end
    end
    
    
  end
  
end
