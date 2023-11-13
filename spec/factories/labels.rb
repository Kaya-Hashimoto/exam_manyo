FactoryBot.define do
  factory :label do
    label_title { "Label1" }

    trait :label2 do
      label_title { "Label2" }
    end

    trait :label3 do
      label_title { "Label3" }
    end
  end
end
