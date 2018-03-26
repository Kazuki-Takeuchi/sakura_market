require 'rails_helper'

feature '購入履歴' do
  background do
    User.create!(name: 'admin', email: 'admin@example.com', password: '123456', admin_type: 1, address: 'address')
    User.create!(name: 'foo', email: 'foo@example.com', password: '123456', address: 'address')
    Commodity.create!(name: 'いちご', price: 200, display_flag: true, display_index: 1)
    Commodity.create!(name: 'さくらんぼ', price: 500, display_flag: true, display_index: 2)
    Commodity.create!(name: 'パイナップル', price: 400, display_flag: false, display_index: 2)
    Commodity.create!(name: 'メロン', price: 3000, display_flag: true, display_index: 2)
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

  scenario '購入' do
    visit root_path
 
    login
    login_user = User.find_by(name: 'foo')
    click_on 'さくらんぼ'
    click_on 'カートに追加する'
    click_on 'お買い物'
    click_on 'いちご'
    click_on 'カートに追加する'
    click_on 'カート情報の保存'

    expect(has_link?('購入する')).to be true
    #click_on '購入する'
    #click_on 'キャンセル'
    #expect(ShoppingHistory.all.size).to eq 0
    click_on '購入する'
    #click_on 'OK'

    click_on 'お買い物'
    click_on 'メロン'
    click_on 'カートに追加する'
    click_on 'カート情報の保存'
    click_on '購入する'

    shopping_history = ShoppingHistory.first
    click_on '購入履歴'
    expect(current_path).to eq user_shopping_histories_path(login_user)

    within '.shopping_history_' + shopping_history.id.to_s do
      within '.payment_method_type' do
        expect(has_text?('代引き')).to be true
      end
      within '.tax_included_price' do
        expect(has_text?('1728円')).to be true
      end
      click_on '詳細'
      expect(current_path).to eq user_shopping_history_path(login_user, shopping_history)
    end

    click_on '戻る'
    expect(current_path).to eq user_shopping_histories_path(login_user)

    within '.shopping_history_' + shopping_history.id.to_s do
      click_on '削除'
    end
    #click_on 'キャンセル'
    #click_on 'OK'
    expect(ShoppingHistory.all.size).to eq 1
    expect(current_path).to eq user_shopping_histories_path(login_user)
  end

  scenario '購入(管理者)' do
    visit root_path

    admin_login
    login_user = User.find_by(name: 'admin')

    click_on 'さくらんぼ'
    click_on 'カートに追加する'
    click_on 'お買い物'
    click_on 'いちご'
    click_on 'カートに追加する'
    click_on 'カート情報の保存'

    expect(has_link?('購入する')).to be true
    #click_on '購入する'
    #click_on 'キャンセル'
    #expect(ShoppingHistory.all.size).to eq 0
    click_on '購入する'
    #click_on 'OK'

    shopping_history = ShoppingHistory.first
    click_on '購入履歴'
    expect(current_path).to eq user_shopping_histories_path(login_user)

    click_on '詳細'
    expect(current_path).to eq user_shopping_history_path(login_user, shopping_history)
    click_on '戻る'
    expect(current_path).to eq user_shopping_histories_path(login_user)

    click_on '削除'
    #click_on 'キャンセル'
    #click_on 'OK'
    expect(ShoppingHistory.all.size).to eq 0
    expect(current_path).to eq user_shopping_histories_path(login_user)
  end
end