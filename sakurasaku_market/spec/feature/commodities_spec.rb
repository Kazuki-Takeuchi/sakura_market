require 'rails_helper'

feature '商品画面' do
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

  scenario 'ログインする' do
    visit root_path

    login

    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario 'ユーザ認証' do
    visit root_path

    login

    ichigo = Commodity.find_by(name: 'いちご')
    visit new_commodity_path
    expect(page.status_code).to eq 500
    visit edit_commodity_path((ichigo))
    expect(page.status_code).to eq 500
    page.driver.delete("/commodities/#{ichigo.id}")
    expect(page.status_code).to eq 500
  end

  scenario '商品閲覧' do
    visit root_path

    login

    expect(has_link?('いちご')).to be true
    expect(has_link?('さくらんぼ')).to be true
    expect(has_link?('パイナップル')).to be false

    ichigo = Commodity.find_by(name: 'いちご')
    within '.commodity' + ichigo.id.to_s do
      expect(has_no_link?('編集')).to be true
      expect(has_no_link?('削除')).to be true
    end
    expect(has_no_link?('商品追加')).to be true

    click_on 'いちご'
    expect(has_no_link?('編集')).to be true
    expect(has_link?('戻る')).to be true
    expect(has_no_text?('表示フラグ')).to be true
    expect(has_no_text?('表示順')).to be true
    expect(current_path).to eq commodity_path(ichigo)
    click_on '戻る'
    expect(current_path).to eq commodities_path
  end

  scenario '商品閲覧(管理者)' do
    visit root_path

    admin_login

    expect(has_link?('いちご')).to be true
    expect(has_link?('さくらんぼ')).to be true
    expect(has_link?('パイナップル')).to be false

    #save_and_open_page
    sakuranbo = Commodity.find_by(name: 'さくらんぼ')
    within '.commodity' + sakuranbo.id.to_s do
      expect(has_link?('編集')).to be true
      expect(has_link?('削除')).to be true
    end
    expect(has_link?('商品追加')).to be true

    click_on 'さくらんぼ'
    expect(has_link?('編集')).to be true
    expect(has_link?('戻る')).to be true
    expect(has_text?('表示フラグ')).to be true
    expect(has_text?('表示順')).to be true
    expect(current_path).to eq commodity_path(sakuranbo)
    click_on '戻る'
    expect(current_path).to eq commodities_path
  end

  scenario '商品削除(管理者)' do
    visit root_path

    admin_login

    expect(has_link?('いちご')).to be true
    ichigo = Commodity.find_by(name: 'いちご')
    within '.commodity' + ichigo.id.to_s do
      expect(has_link?('削除')).to be true
      click_on '削除'
    end

    expect(has_no_link?('いちご')).to be true
  end


  scenario '商品追加(管理者)' do
    visit root_path

    admin_login

    expect(has_no_link?('りんご')).to be true
    click_on '商品追加'
    click_on '保存'
    #　必須チェック
    expect(has_text?('Nameを入力してください')).to be true
    expect(has_text?('Priceを入力してください')).to be true
    expect(has_text?('Display indexを入力してください')).to be true

    fill_in 'commodity_name', with: 'りんご'
    fill_in 'commodity_price', with: 300
    check 'commodity_display_flag'
    fill_in 'commodity_display_index', with: 5
    click_on '保存'
    ringo = Commodity.find_by(name: 'りんご')
    expect(current_path).to eq commodity_path(ringo)
    click_on '戻る'
    expect(has_link?('りんご')).to be true
  end

  scenario '商品編集(管理者)' do
    visit root_path

    admin_login

    expect(has_link?('さくらんぼ')).to be true
    sakuranbo = Commodity.find_by(name: 'さくらんぼ')
    within '.commodity' + sakuranbo.id.to_s do
      click_on '編集'
    end
    fill_in 'commodity_name', with: 'レモン'
    click_on '保存'
    sakuranbo = Commodity.find_by(name: 'レモン')
    expect(current_path).to eq commodity_path(sakuranbo)
    click_on '戻る'
    expect(has_no_link?('さくらんぼ')).to be true
    expect(has_link?('レモン')).to be true
  end
end