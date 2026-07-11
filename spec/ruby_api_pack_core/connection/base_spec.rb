# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubyApiPackCore::Connection::Base do
  subject(:connection) { dummy_connection_class.new('https://example.test/api', '/things') }

  let(:dummy_connection_class) do
    Class.new(described_class) do
      private

      def auth_headers
        { 'Authorization' => 'Bearer fake_token' }
      end
    end
  end
  let(:success_response) do
    instance_double(
      HTTParty::Response,
      code: 200,
      body: '{"id":1,"name":"Thing"}',
      headers: { 'content-type' => 'application/json' }
    )
  end
  let(:error_response) do
    instance_double(
      HTTParty::Response,
      code: 500,
      body: '{"message":"Internal error"}',
      headers: { 'content-type' => 'application/json' }
    )
  end

  describe '#api_get' do
    it 'performs an authenticated GET request' do
      allow(HTTParty).to receive(:get).and_return(success_response)

      connection.api_get

      expect(HTTParty).to have_received(:get).with(
        'https://example.test/api/things',
        hash_including(headers: { 'Authorization' => 'Bearer fake_token' }, query: {})
      )
    end

    it 'returns the parsed JSON body' do
      allow(HTTParty).to receive(:get).and_return(success_response)

      expect(connection.api_get).to eq({ 'id' => 1, 'name' => 'Thing' })
    end

    it 'raises when the response is not a 2xx' do
      allow(HTTParty).to receive(:get).and_return(error_response)

      expect { connection.api_get }.to raise_error(/Error: Received status 500/)
    end
  end

  describe '#api_post' do
    it 'performs an authenticated POST request with a JSON body' do
      allow(HTTParty).to receive(:post).and_return(success_response)

      connection.api_post(name: 'Thing')

      expect(HTTParty).to have_received(:post).with(
        'https://example.test/api/things',
        hash_including(
          headers: { 'Authorization' => 'Bearer fake_token', 'Content-Type' => 'application/json' },
          body: { name: 'Thing' }.to_json
        )
      )
    end
  end

  describe '#api_put' do
    it 'performs an authenticated PUT request with a JSON body' do
      allow(HTTParty).to receive(:put).and_return(success_response)

      connection.api_put(name: 'Updated Thing')

      expect(HTTParty).to have_received(:put).with(
        'https://example.test/api/things',
        hash_including(headers: { 'Authorization' => 'Bearer fake_token', 'Content-Type' => 'application/json' })
      )
    end
  end

  describe '#api_delete' do
    it 'performs an authenticated DELETE request' do
      allow(HTTParty).to receive(:delete).and_return(success_response)

      connection.api_delete(force: true)

      expect(HTTParty).to have_received(:delete).with(
        'https://example.test/api/things',
        hash_including(headers: { 'Authorization' => 'Bearer fake_token' }, query: { force: true })
      )
    end
  end

  describe 'parsing failures' do
    let(:invalid_json_response) do
      instance_double(
        HTTParty::Response,
        code: 200,
        body: 'not-json',
        headers: { 'content-type' => 'application/json' }
      )
    end

    it 'raises a descriptive parsing error' do
      allow(HTTParty).to receive(:get).and_return(invalid_json_response)
      allow(Oj).to receive(:load).and_raise(Oj::ParseError.new('Unexpected character'))

      expect { connection.api_get }.to raise_error(/Error parsing response: Unexpected character/)
    end

    it 'raises when the content type is not JSON' do
      non_json_response = instance_double(
        HTTParty::Response,
        code: 200,
        body: '<html></html>',
        headers: { 'content-type' => 'text/html' }
      )
      allow(HTTParty).to receive(:get).and_return(non_json_response)

      expect { connection.api_get }.to raise_error(/Unexpected response/)
    end

    it 'returns an empty hash for an empty body' do
      empty_response = instance_double(
        HTTParty::Response,
        code: 200,
        body: '',
        headers: { 'content-type' => 'application/json' }
      )
      allow(HTTParty).to receive(:get).and_return(empty_response)

      expect(connection.api_get).to eq({})
    end
  end

  describe 'unimplemented #auth_headers' do
    it 'raises NotImplementedError when a subclass does not override it' do
      bare_subclass = Class.new(described_class)
      bare_connection = bare_subclass.new('https://example.test/api', '/things')

      expect { bare_connection.send(:auth_headers) }.to raise_error(NotImplementedError, /must implement #auth_headers/)
    end
  end
end
