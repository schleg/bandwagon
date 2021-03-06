require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'rspec/autorun'
  require 'helpers'
  include Helpers
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  RSpec.configure do |config|
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
    DatabaseCleaner.strategy = :truncation
    RSpec.configure do |config|
      config.before(:each) do
        DatabaseCleaner.start
      end
      config.after(:each) do
        DatabaseCleaner.clean
      end
      config.after(:all) do
        if Rails.env.test? 
          FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
        end 
      end
    end
  end
end

Spork.each_run do
end
