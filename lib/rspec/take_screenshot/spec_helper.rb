require 'rspec'
require 'rspec_take_screenshot'

module Rspec
  module TakeScreenshot
    module SpecHelper
      def rspec_take_screenshot(name: nil, suffix: '')
        return unless ::Rspec::TakeScreenshot.configuration.enabled?

        handler = current_rspec_take_screenshot
        example = current_rspec_take_screenshot.example
        auto_increment = handler.auto_increment?

        filename = name.presence || (example ? handler.name_with_example(example) : '')
        handler.call(
          page: page,
          name: filename,
          suffix: auto_increment ? handler.count : suffix,
        )

        if handler.auto_increment?
          handler.count_up
        end
      end

      def current_rspec_take_screenshot
        @current_rspec_take_screenshot ||= ::Rspec::TakeScreenshot::Handler.new
      end
    end
  end
end

RSpec.configure do |config|
  %i[system feature].each do |type|
    config.before type: type do |example|
      current_rspec_take_screenshot.reset
      current_rspec_take_screenshot.example = example
      if example.metadata[:take_screenshot_auto_increment]
        current_rspec_take_screenshot.enable_auto_increment
      end
    end
  end
end
