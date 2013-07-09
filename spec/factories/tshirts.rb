# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tshirt do
    title { Faker::Lorem::word }
    description { Faker::Lorem::paragraph }
    artwork { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "support", "artwork", "1x1.png")) }
  end
end
