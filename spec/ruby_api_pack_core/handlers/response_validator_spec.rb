# frozen_string_literal: true

require 'spec_helper'
require 'logger'

RSpec.describe RubyApiPackCore::Handlers::ResponseValidator do
  let(:dummy_class) do
    Class.new do
      extend RubyApiPackCore::Handlers::ResponseValidator
    end
  end

  describe '.validate_response' do
    it 'returns the response when no type is expected' do
      expect(dummy_class.validate_response({ 'id' => 1 })).to eq({ 'id' => 1 })
    end

    it 'returns the response when it matches the expected array type' do
      expect(dummy_class.validate_response([1, 2], expected_type: :array)).to eq([1, 2])
    end

    it 'raises when an array was expected but a hash was returned' do
      expect { dummy_class.validate_response({ 'id' => 1 }, expected_type: :array) }
        .to raise_error(/Expected an Array/)
    end

    it 'returns the response when it matches the expected hash type' do
      expect(dummy_class.validate_response({ 'id' => 1 }, expected_type: :hash)).to eq({ 'id' => 1 })
    end

    it 'raises when a hash was expected but an array was returned' do
      expect { dummy_class.validate_response([1, 2], expected_type: :hash) }
        .to raise_error(/Expected a Hash/)
    end
  end

  describe '.log_error' do
    context 'when Rails is defined' do
      it 'logs the error using Rails.logger' do
        logger = instance_spy(Logger)
        stub_const('Rails', Class.new)
        allow(Rails).to receive(:logger).and_return(logger)

        dummy_class.send(:log_error, 'Test error')
        expect(logger).to have_received(:error).with('Test error')
      end
    end

    context 'when Rails is not defined' do
      it 'logs the error using puts' do
        allow(dummy_class).to receive(:puts)
        dummy_class.send(:log_error, 'Test error')
        expect(dummy_class).to have_received(:puts).with('[ERROR] Test error')
      end
    end
  end
end
