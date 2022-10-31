# frozen_string_literal: true

RSpec.describe Rspec::TakeScreenshot::Handler do
  describe '#name_with_example' do
    it do |example|
      handler = described_class.new
      expect(handler.name_with_example(example)).to eq('Rspec::TakeScreenshot::Handler/#name_with_example')
    end

    it 'return description' do |example|
      handler = described_class.new
      expect(handler.name_with_example(example)).to eq('Rspec::TakeScreenshot::Handler/#name_with_example/return description')
    end
  end
end
