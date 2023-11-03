FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったタイトル1' }
    content { 'Factoryで作ったコンテンツ1' }
    expired_at { '002023-11-11T10:00' }
    status { 1 }
  end

  factory :second_task, class: Task do
    title { 'factoryで作ったタイトル2'}
    content { 'Factoryで作ったコンテンツ2' }
    expired_at { '002023-11-30T10:00' }
    status { 0 }
  end
end