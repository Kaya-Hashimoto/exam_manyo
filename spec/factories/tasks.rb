FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
  end

  factory :second_task, class: Task do
    title {'factoryで作ったデフォルトのタイトル2'}
    content { 'Factoryで作ったデフォルトのコンテント2'}
    title {'factoryで作ったデフォルトのタイトル3'}
    content { 'Factoryで作ったデフォルトのコンテント3'}
    title {'factoryで作ったデフォルトのタイトル4'}
    content { 'Factoryで作ったデフォルトのコンテント4'}
  end
end