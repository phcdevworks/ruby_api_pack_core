# frozen_string_literal: true

module RubyApiPackCore
  module Handlers
    module ResponseValidator
      def validate_response(response, expected_type: :any)
        case expected_type
        when :array
          raise "Expected an Array, got #{response.class}: #{response.inspect}" unless response.is_a?(Array)
        when :hash
          raise "Expected a Hash, got #{response.class}: #{response.inspect}" unless response.is_a?(Hash)
        end

        response
      rescue StandardError => e
        log_error("Error validating response: #{e.message}")
        raise "An error occurred while processing the response: #{e.message}"
      end

      private

      def log_error(message)
        if defined?(Rails)
          Rails.logger.error(message)
        else
          puts "[ERROR] #{message}"
        end
      end
    end
  end
end
