require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル', with: 'サンプル１'
        fill_in '内容', with: 'サンプル1'
        fill_in '終了期限', with: '002023-11-22T1400'
        click_on '送信'
        expect(page).to have_content 'タスクを作成しました'
      end
    end
  end
  let!(:task) { FactoryBot.create(:task, title: 'task') }
  let!(:second_task) { FactoryBot.create(:second_task) }
  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の古い順に並んでいる場合' do
      it '終了期限でソートすると期限の降順に表示される' do
        click_on '終了期限でソートする'
        task_list = all('p').first
        expect(task_list).to have_content 'タイトル2'
      end
    end
  end
end