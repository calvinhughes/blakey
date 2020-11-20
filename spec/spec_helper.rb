# frozen_string_literal: true

require 'bundler/setup'
require 'blakey'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def fixture(file)
  fixture_path = File.expand_path("../fixtures", __FILE__)
  File.new(fixture_path + '/' + file)
end

def blakey_test_source_github_access_token
  ENV.fetch('BLAKEY_TEST_SOURCE_GITHUB_ACCESS_TOKEN', 'fake_github_access_token')
end
