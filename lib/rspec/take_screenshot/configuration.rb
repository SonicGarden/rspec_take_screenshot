module Rspec
  module TakeScreenshot
    class Configuration
      attr_accessor :enabled, :root_dir, :window_sizes

      def initialize
        @enabled = ENV.has_key?('TAKE_SCREENSHOT')
        @root_dir = Rails.root.join('tmp/screenshots')
        @window_sizes = [
          WindowSize.new(
            name: :default,
            width: 1024,
            height: 768,
            )
        ]
      end

      def root_dir=(root_dir)
        @root_dir = Rails.root.join(root_dir)
      end

      def add_multi_sizes(name:, width:, height:)
        @window_sizes << [
          WindowSize.new(name: name, width: width, height: height)
        ]
      end

      def enabled?
        !!@enabled
      end
    end
  end
end
