# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |e| "user_#{e}@example.com" }
  factory :user do
    email { FactoryGirl.generate(:email) }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :admin, parent: :user do
    after(:create) {|user| user.add_role(:admin)}
  end
  factory :signed_out_user, parent: :user
  factory :confirmed_user, parent: :user do
    confirmed_at { Date.today }
  end
  factory :visitor, parent: :user
end

