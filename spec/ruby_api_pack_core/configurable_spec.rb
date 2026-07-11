# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyApiPackCore::Configurable do
  let(:dummy_configuration_class) do
    Class.new do
      attr_accessor :api_key
    end
  end

  let(:dummy_module) do
    config_class = dummy_configuration_class

    Module.new do
      extend RubyApiPackCore::Configurable

      define_singleton_method(:configuration_class) { config_class }
    end
  end

  describe '#configure' do
    it 'memoizes a configuration instance and yields it' do
      dummy_module.configure do |config|
        config.api_key = 'fake_key'
      end

      expect(dummy_module.configuration.api_key).to eq('fake_key')
    end

    it 'reuses the same configuration instance across multiple configure calls' do
      dummy_module.configure { |config| config.api_key = 'first' }
      first_instance = dummy_module.configuration

      dummy_module.configure { |config| config.api_key = 'second' }

      expect(dummy_module.configuration).to equal(first_instance)
      expect(dummy_module.configuration.api_key).to eq('second')
    end
  end
end
