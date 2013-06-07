# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:title) { |e| "Tshirt ##{e}" }
  factory :tshirt do
    title { FactoryGirl.generate(:title) }
    description { Faker::Lorem::paragraph }
  end
end
