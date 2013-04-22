# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tshirt do
    title "MyString"
    description "MyText"
    state "MyString"
    user_id 1
  end
end
