FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったタイトル1' }
    content { 'Factoryで作ったコンテント1' }
    expired_at { '0020231111T1000'}
  end

  factory :second_task, class: Task do
    title {'factoryで作ったタイトル2'}
    content { 'Factoryで作ったコンテント2'}
    expired_at { '0020231031T1000'}
  end
end