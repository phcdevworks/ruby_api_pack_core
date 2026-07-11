# frozen_string_literal: true

require_relative 'lib/ruby_api_pack_core/version'

Gem::Specification.new do |spec|
  spec.name = 'ruby_api_pack_core'
  spec.version = RubyApiPackCore::VERSION
  spec.authors     = ['PHCDevworks', 'Brad Potts']
  spec.email       = ['info@phcdevworks.com', 'brad.potts@phcdevworks.com']
  spec.homepage    = 'https://phcdevworks.com/'

  spec.summary     = 'Shared HTTP client foundation for PHCDevworks Ruby API pack gems.'
  spec.description = 'RubyApiPackCore provides the shared connection wrapper, response validator, and ' \
                     'configuration pattern used by every ruby_api_pack_* gem, so each vendor-specific API ' \
                     'pack only has to implement its own authentication headers and resource endpoints.'
  spec.license = 'MIT'

  # Specify the required Ruby version
  spec.required_ruby_version = '>= 3.3.0'

  # Gem Meta Data
  spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/phcdevworks/ruby_api_pack_core/'
  spec.metadata['changelog_uri'] = 'https://github.com/phcdevworks/ruby_api_pack_core/releases'
  spec.metadata['rubygems_mfa_required'] = 'true'

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Main Dependencies
  spec.add_dependency 'httparty', '~> 0.24.2'
  spec.add_dependency 'oj', '~> 3.17'
end
