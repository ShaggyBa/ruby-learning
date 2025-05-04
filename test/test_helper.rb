require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/test/'    # вместо '/spec/'
  add_filter '/config/'
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all
    # …
  end
end

