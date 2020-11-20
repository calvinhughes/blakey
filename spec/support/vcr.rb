# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  record_option = ENV['CI'] ? :none : :once

  c.default_cassette_options = {
    record: record_option
  }

  c.filter_sensitive_data('<GITHUB_ACCESS_TOKEN>') do
    blakey_test_source_github_access_token
  end
end
