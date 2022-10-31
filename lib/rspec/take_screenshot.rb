require 'active_support/all'

require_relative "take_screenshot/version"
require_relative "take_screenshot/window_size"
require_relative "take_screenshot/configuration"
require_relative "take_screenshot/handler"
require_relative "take_screenshot/spec_helper"

module Rspec
  module TakeScreenshot
    class << self
      def configure
        yield configuration
      end

      def configuration
        @configuration ||= Configuration.new
      end
    end
  end
end
