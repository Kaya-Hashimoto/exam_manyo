require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { create(:user) }
  let!(:label) { create(:label) }
  context 'タスクの新規作成時' do
    it 'ラベルも一緒につけられること' do
      login(user)
      visit new_task_path
      fill_in 'タイトル', with: 'サンプル１'
      fill_in '内容', with: 'サンプル1'
      fill_in '終了期限', with: '002023-11-22T14:00'
      select '完了', from: 'task_status'
      check 'Label1'
      click_on '送信'
      expect(page).to have_content 'Label1'
    end
  end
  context 'タスクにラベルが紐づいてる時' do
    let!(:task) { create(:task, user: user) }
    before do
      login(user)
      visit tasks_path
    end
    it 'ラベルで検索できること' do
      select 'Label2', from: 'label_ids'
      click_on '検索'
      label_list = all('tbody td')[4]
      expect(label_list).to have_content 'Label2'
    end
    it 'ラベルのつけ外しができる事' do
      click_on '編集'
      check 'Label1'
      uncheck 'Label2'
      click_on '送信'
      expect(page).to have_content 'Label1'
    end
  end
end