require 'rubygems'
require 'spork'
require 'machinist/active_record'
require 'faker'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  unless defined?(Rails)
    require File.dirname(__FILE__) + "/../config/environment"
  end
  require 'rspec/rails'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  Rspec.configure do |config|
  # Reset the Machinist cache before each spec.
  config.before(:each) { Machinist.reset_before_test }

    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, comment the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    ### Part of a Spork hack. See http://bit.ly/arY19y
    # Emulate initializer set_clear_dependencies_hook in 
    # railties/lib/rails/application/bootstrap.rb
    ActiveSupport::Dependencies.clear
  end
end

Spork.each_run do
end


# blueprints

User.blueprint do
  email { Faker::Internet.email }
  password { "password" }
  password_confirmation { "password" }
  is_admin { false }
end

User.blueprint(:admin) do
  is_admin { true }
end

Survey.blueprint do
  name { Faker::Lorem.words(2) }
  intro { Faker::Lorem.words(40) }
  thank_you { Faker::Lorem.words(40) }
  end_date { Date.today + 30 }
end

Question.blueprint do
  content { Faker::Lorem.words(8) }
  kind { "text" }
end

Recipient.blueprint do
  email { Faker::Internet.email }
end

Recipient.blueprint(:no_email) do
  no_email { true }
end

Answer.blueprint do
  content { Faker::Lorem.words(3) }
end
