FactoryBot.define do
  factory :user do

    name { 'test1' }
    email { 'xx@mail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { 'false' }

    trait :second_user do
      name { 'test2' }
      email { 'xx2@mail.com' }
    end

    trait :admin do
      name { 'admin1' }
      email { 'admin@mail.com' }
      password { 'adminadm' }
      password_confirmation { 'adminadm' }
      admin { 'true' }
    end
  end
end
