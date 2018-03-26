require 'rails_helper'

feature 'ショッピングカート' do
  background do
    User.create!(name: 'admin', email: 'admin@example.com', password: '123456', admin_type: 1)
    User.create!(name: 'foo', email: 'foo@example.com', password: '123456')
    Commodity.create!(name: 'いちご', price: 200, display_flag: true, display_index: 1)
    Commodity.create!(name: 'さくらんぼ', price: 500, display_flag: true, display_index: 2)
    Commodity.create!(name: 'パイナップル', price: 400, display_flag: false, display_index: 2)
  end

  def login
    click_on 'ログイン'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    expect(page).to have_content 'ログインしました'
  end

  def admin_login
    click_on 'ログイン'
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    expect(page).to have_content 'ログインしました'
  end

  scenario 'ショッピングカート追加削除' do
    visit root_path
    click_on 'ショッピングカート'
    # ログイン前はルートに移動
    expect(current_path).to eq root_path
 
    login
    login_user = User.find_by(name: 'foo')
    click_on 'ショッピングカート'
    expect(current_path).to eq new_user_shopping_cart_path(login_user)

    expect(has_link?('購入する')).to be false

    #入らない fill_in 'shopping_cart_address', with: '配送先'
    #save_and_open_page
    click_on 'カート情報の保存'
    #expect(login_user.address).to eq '配送先'

    expect(has_link?('カートを削除する')).to be true
    click_on 'カートを削除する'
    expect(current_path).to eq root_path
  end

  scenario 'ショッピングカート 商品追加' do
    visit root_path
    click_on 'ショッピングカート'
    # ログイン前はルートに移動
    expect(current_path).to eq root_path
 
    login
    login_user = User.find_by(name: 'foo')
    click_on 'さくらんぼ'
    click_on 'カートに追加する'
    expect(current_path).to eq edit_user_shopping_cart_path(login_user, login_user.shopping_cart)

    click_on 'お買い物'

    click_on 'いちご'
    click_on 'カートに追加する'
    expect(current_path).to eq edit_user_shopping_cart_path(login_user, login_user.shopping_cart)

    within '.subtotal' do
      expect(has_text?('700円')).to be true
    end
    within '.shopping_fee' do
      expect(has_text?('600円')).to be true
    end
    within '.cash_on_delivery_commission' do
      expect(has_text?('300円')).to be true
    end
    within '.total' do
      expect(has_text?('1600円')).to be true
    end
    within '.tax_included_price' do
      expect(has_text?('1728円')).to be true
    end

    expect(has_link?('さくらんぼ')).to be true
    sakuranbo = Commodity.find_by(name: 'さくらんぼ')
    cart_item = login_user.shopping_cart.shopping_cart_items.select{|item| item.commodity == sakuranbo}.first
    within '.shopping_cart_item_' + cart_item.id.to_s do
      click_on 'カートから削除する'
    end
    expect(has_no_link?('さくらんぼ')).to be true
  end

  scenario 'ショッピングカート(管理者)' do
    visit root_path

    admin_login
    login_user = User.find_by(name: 'admin')

    click_on 'ショッピングカート'
    expect(current_path).to eq new_user_shopping_cart_path(login_user)
    #入らない fill_in 'shopping_cart_address', with: '配送先'
    click_on 'カート情報の保存'
    #expect(login_user.address).to eq '配送先'

    expect(has_link?('カートを削除する')).to be true
    click_on 'カートを削除する'
    expect(current_path).to eq root_path

    click_on 'いちご'
    click_on 'カートに追加する'
    expect(current_path).to eq edit_user_shopping_cart_path(login_user, login_user.shopping_cart)

    expect(has_link?('いちご')).to be true
    ichigo = Commodity.find_by(name: 'いちご')
    cart_item = login_user.shopping_cart.shopping_cart_items.select{|item| item.commodity == ichigo}.first
    within '.shopping_cart_item_' + cart_item.id.to_s do
      click_on 'カートから削除する'
    end
    expect(has_no_link?('いちご')).to be true
  end
end