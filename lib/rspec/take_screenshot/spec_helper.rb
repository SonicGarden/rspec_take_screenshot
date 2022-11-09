require 'rspec'
require 'rspec_take_screenshot'

module Rspec
  module TakeScreenshot
    module SpecHelper
      def rspec_take_screenshot(name: nil, suffix: '')
        return unless ::Rspec::TakeScreenshot.configuration.enabled?

        handler = current_rspec_take_screenshot
        example = current_rspec_take_screenshot_example
        filename = name.presence || (example ? handler.name_with_example(example) : '')
        handler.call(page: page, name: filename, suffix: suffix)
      end

      def current_rspec_take_screenshot
        @current_rspec_take_screenshot ||= ::Rspec::TakeScreenshot::Handler.new
      end

      def set_current_rspec_take_screenshot_example(example)
        @current_rspec_take_screenshot_example = example
      end

      def current_rspec_take_screenshot_example
        @current_rspec_take_screenshot_example
      end
    end
  end
end

RSpec.configure do |config|
  %i[system feature].each do |type|
    config.before type: type do |example|
      set_current_rspec_take_screenshot_example(example)
    end
  end
end
