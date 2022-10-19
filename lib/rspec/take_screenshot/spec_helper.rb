require 'rspec'
require 'rspec_take_screenshot'

module Rspec
  module TakeScreenshot
    module SpecHelper
      def take_screenshot(name: nil, suffix: '')
        return unless ::Rspec::TakeScreenshot.configuration.enabled?

        filename = name.presence || current_take_screenshot_example&.full_description&.gsub(' ', '/')
        current_take_screenshot.call(page: page, name: filename, suffix: suffix)
      end

      def current_take_screenshot
        @current_take_screenshot ||= ::Rspec::TakeScreenshot::Handler.new
      end

      def set_current_take_screenshot_example(example)
        @current_take_screenshot_example = example
      end

      def current_take_screenshot_example
        @current_take_screenshot_example
      end
    end
  end
end

RSpec.configure do |config|
  %i[system feature].each do |type|
    config.before type: type do |example|
      set_current_take_screenshot_example(example)
    end
  end
end
