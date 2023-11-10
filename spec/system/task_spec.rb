require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        login(user)
        visit new_task_path
        fill_in 'タイトル', with: 'サンプル１'
        fill_in '内容', with: 'サンプル1'
        fill_in '終了期限', with: '002023-11-22T14:00'
        select '完了', from: 'task_status'
        click_on '送信'
        expect(page).to have_content 'タスクを作成しました'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, title: 'task', user: user) }
    let!(:second_task) { FactoryBot.create(:task, :second_task, user: user ) }
    before do
      login(user)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の古い順に並んでいる場合' do
      it '該当タスクの内容が一番上に表示される' do
        expect(page).to have_content 'コンテンツ1'
      end
    end
    context 'タスクが作成日時の古い順に並んでいる場合' do
      it '終了期限でソートすると期限の降順に表示される' do
        click_on '終了期限でソートする'
        sleep(0.5)
        task_list = all('tbody td')[4]
        expect(task_list).to have_content '2023/11/30'
      end
    end
  end
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, title: 'hello', user: user) }
    let!(:second_task) { FactoryBot.create(:task, :second_task, user: user ) }
    before do
      login(user)
      visit tasks_path
    end
    context 'タイトルであいまい検索した場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        fill_in 'タイトル', with: 'hell'
        click_on '検索'
        expect(page).to have_content 'hello'
      end
    end
    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致したタスクが表示される' do
        select '未着手', from: 'status'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードを含むステータスに完全一致するタスクに絞り込まれる' do
        fill_in 'タイトル', with: 'he'
        select '着手中', from: 'status'
        click_on '検索'
        expect(page).to have_content 'he' and have_content '着手中'
      end
    end
  end
end