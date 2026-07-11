# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter 'lib/ruby_api_pack_core/version'
  track_files 'lib/ruby_api_pack_core/**/*.rb'
  enable_coverage :branch
end

require 'ruby_api_pack_core'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  Kernel.srand config.seed
end
