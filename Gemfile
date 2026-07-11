# frozen_string_literal: true

source 'https://rubygems.org'
gemspec

# multi_xml >= 0.7.2 drops Ruby 3.1 support; httparty's dependency on multi_xml
# is unbounded, so pin it directly to stay compatible with required_ruby_version.
gem 'multi_xml', '0.7.1'

group :development, :test do
  gem 'bundler', '~> 2.5'
  # parallel >= 2.0 requires Ruby >= 3.3; rubocop's dependency on parallel is
  # unbounded, so pin it directly to stay compatible with required_ruby_version.
  gem 'parallel', '1.28.0'
  gem 'rake', '~> 13.2'
  gem 'rspec', '~> 3.13'
  gem 'rubocop', '~> 1.64', require: false
  gem 'rubocop-performance', '~> 1.21', require: false
  gem 'rubocop-rake', '~> 0.7.0', require: false
  gem 'rubocop-rspec', '~> 3.0', require: false
  gem 'simplecov', '~> 0.22.0', require: false
end
