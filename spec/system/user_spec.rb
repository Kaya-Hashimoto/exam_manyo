require 'rails_helper'
RSpec.describe 'ユーザーに関する機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:user, :second_user) }
  describe '新規登録' do
    context 'ユーザーが新規登録した場合' do
      it 'マイページに移動する' do
        visit new_user_path
        fill_in 'Name', with: 'user1'
        fill_in 'Email', with: 'test@mail.com'
        fill_in 'Password', with: 'testes'
        fill_in 'Password confirmation', with: 'testes'
        click_on 'アカウント作成'
        expect(page).to have_content '新規登録しました'
      end
    end
    context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に移動する' do
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe 'セッション機能' do
    context 'ユーザーがログインしようとした場合' do
      it 'ログインができてマイページに移動する' do
        login(user)
        expect(page).to have_content 'マイページ'
      end
    end
    context '他のユーザーのマイページに飛ぼうとした場合' do
      it '自分のタスク一覧画面に飛ばされる' do
        login(user)
        visit user_path(second_user.id)
        expect(current_path).to eq tasks_path
      end
    end
  end

  describe '管理画面に関する機能' do
    let!(:admin) { FactoryBot.create(:user, :admin) }
    context '管理ユーザーがログインしたら' do
      before do
        admin_login(admin)
      end
      it '管理画面にアクセスできる' do
        expect(page).to have_content '管理画面'
      end
      it 'ユーザーの新規登録ができる' do
        click_on 'ユーザー新規作成'
        fill_in 'Name', with: 'user1'
        fill_in 'Email', with: 'test@mail.com'
        fill_in 'Password', with: 'testes'
        fill_in 'Password confirmation', with: 'testes'
        click_on '作成'
        expect(page).to have_content 'ユーザーを作成しました'
      end
      it '一般ユーザーの詳細画面を見れる' do
        first('tbody tr').click_on '詳細'
        expect(current_path).to eq user_path(user.id)
      end
      it '編集画面でユーザーの情報を編集できる' do
        first('tbody tr').click_on '編集'
        fill_in 'Password', with: 'testtest'
        fill_in 'Password confirmation', with: 'testtest'
        click_on '更新'
        expect(page).to have_content '更新しました'
      end
      it 'ユーザーの削除ができる' do
        first('tbody tr').click_on '削除'
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content '削除しました'
      end
    end
    context '一般ユーザーが管理画面にアクセスしようとしたら' do
      it 'アクセスできないこと' do
        login(user)
        visit admin_users_path
        expect(page).to have_content '管理者以外アクセスできません'
      end
    end
  end
end