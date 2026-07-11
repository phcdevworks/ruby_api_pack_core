# frozen_string_literal: true

module RubyApiPackCore
  # Extend a top-level gem module with this to get the standard
  # `MyGem.configure { |c| ... }` / `MyGem.configuration` singleton pattern.
  #
  # The extending module must implement `.configuration_class`, returning the
  # Configuration class to instantiate, e.g.:
  #
  #   module MyGem
  #     extend RubyApiPackCore::Configurable
  #
  #     def self.configuration_class
  #       Configuration
  #     end
  #   end
  module Configurable
    attr_accessor :configuration

    def configure
      self.configuration ||= configuration_class.new
      yield(configuration)
    end
  end
end
