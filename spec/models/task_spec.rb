require 'rails_helper'
RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに引っ掛かる' do
        task = Task.new(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションに引っ掛かる' do
          task = Task.new(title: 'テスト', content: '')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(title:'テスト', content: '成功テスト')
          expect(task).to be_valid
        end
      end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'good', status: '完了') }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'night', status: '着手中') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.search_title('good')).to include(task)
        expect(Task.search_title('good')).not_to include(second_task)
        expect(Task.search_title('good').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_status('完了')).to include(task)
        expect(Task.search_status('完了')).not_to include(second_task)
        expect(Task.search_status('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含みステータスが完全一致するタスクが絞り込まれる' do
        task_search = Task.search_title('night').search_status('着手中')
        expect(task_search).to include(second_task)
        expect(task_search).not_to include(task)
        expect(task_search.count).to eq 1
      end
    end
  end
end
