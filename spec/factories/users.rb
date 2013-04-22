# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) { |e| "user_#{e}@example.com" }
  factory :user do
    email { FactoryGirl.generate(:email) }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :admin, parent: :user
  factory :signed_out_user, parent: :user
end

