ENV['RAILS_ENV'] ||= 'test'
require "simplecov"
SimpleCov.start
require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# https://mattbrictson.com/strict-validations-minitest-and-shoulda
# https://mattbrictson.com/minitest-and-rails