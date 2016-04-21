require "simplecov"

SimpleCov.start :rails do
  add_filter "version.rb"
  add_filter "install_generator.rb"
end

ENV["RAILS_ENV"] = "test"

begin
  require File.expand_path("../dummy/config/environment.rb", __FILE__)
rescue LoadError
  puts "Could not load dummy application. Run `bundle exec rake test_app` first"
  exit
end

require "rspec/rails"
require "ffaker"
require "pry-byebug"

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

require "spree/testing_support/authorization_helpers"
require "spree/testing_support/capybara_ext"
require "spree/testing_support/controller_requests"
require "spree/testing_support/factories"
require "spree/testing_support/url_helpers"

require "spree_handling_fees/factories"

RSpec.configure do |config|
  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include Spree::TestingSupport::UrlHelpers
  config.include Devise::TestHelpers, type: :controller

  config.deprecation_stream = "rspec.log"
  config.example_status_persistence_file_path = "spec/examples.txt"
  # config.profile_examples = 10

  config.mock_with :rspec

  config.infer_spec_type_from_file_location!
end
