# frozen_string_literal: true

require 'httparty'
require 'oj'

module RubyApiPackCore
  module Connection
    # Shared HTTParty + Oj request/response plumbing for API pack connection
    # wrappers. Subclasses provide the vendor-specific piece by implementing
    # `#auth_headers` (a Hash merged into every request's headers). Everything
    # else -- URL building, verb dispatch, status handling, JSON parsing, and
    # error messages -- is identical across packs.
    class Base
      attr_reader :api_url_base, :api_path

      def initialize(api_url_base, api_path)
        @api_url_base = api_url_base
        @api_path = api_path
      end

      def api_get(params = {})
        response = HTTParty.get(
          full_url,
          headers: auth_headers,
          query: params,
          ssl_version: :TLSv1_2
        )
        handle_response(response)
      end

      def api_post(params = {})
        response = HTTParty.post(
          full_url,
          headers: auth_headers.merge('Content-Type' => 'application/json'),
          body: params.to_json,
          ssl_version: :TLSv1_2
        )
        handle_response(response)
      end

      def api_put(params = {})
        response = HTTParty.put(
          full_url,
          headers: auth_headers.merge('Content-Type' => 'application/json'),
          body: params.to_json,
          ssl_version: :TLSv1_2
        )
        handle_response(response)
      end

      def api_delete(params = {})
        response = HTTParty.delete(
          full_url,
          headers: auth_headers,
          query: params,
          ssl_version: :TLSv1_2
        )
        handle_response(response)
      end

      private

      # Subclasses must implement this, returning a Hash of auth headers
      # (e.g. an API-token header, an OAuth bearer token, or Basic auth).
      def auth_headers
        raise NotImplementedError, "#{self.class} must implement #auth_headers"
      end

      def full_url
        "#{@api_url_base}#{@api_path}"
      end

      def handle_response(response)
        case response.code
        when 200..299
          parse_response(response)
        else
          raise "Error: Received status #{response.code} - #{response.body}"
        end
      end

      def parse_response(response)
        return {} if response.body.nil? || response.body.empty?

        content_type = response.headers&.fetch('content-type', nil)
        raise "Unexpected response: #{response.body}" unless content_type&.include?('application/json')

        Oj.load(response.body, mode: :strict)
      rescue Oj::ParseError => e
        raise "Error parsing response: #{e.message}. Raw body: #{response.body}"
      end
    end
  end
end
