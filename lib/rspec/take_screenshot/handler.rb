module Rspec
  module TakeScreenshot
    class Handler
      attr_accessor :example

      def configuration
        ::Rspec::TakeScreenshot.configuration
      end

      def call(page:, name: nil, suffix: '')
        root_dir = configuration.root_dir
        file_base_path = File.join(root_dir, "#{[name, suffix].reject(&:blank?).join('_')}.png")
        FileUtils.mkdir_p(File.dirname(file_base_path))

        configuration.window_sizes.each do |window_size|
          size_suffix = window_size.name == :default ? '' : window_size.name
          file_path = File.join(root_dir, "#{[name, suffix, size_suffix].reject(&:blank?).join('_')}.png")

          width = window_size.width
          height = begin
                     page.evaluate_script('document.querySelector("body").clientHeight')
                   rescue
                     window_size.height
                   end

          temporary_resize(page, width, height) do
            page.save_screenshot(file_path)
          end
        end
      end

      def name_with_example(example)
        example_descriptions(example.metadata).reject(&:blank?).join('/')
      end

      private

      def example_descriptions(metadata)
        group = metadata[:example_group]
        description = metadata[:description]
        group ? example_descriptions(group) + [description] : [description]
      end

      def temporary_resize(page, width, height)
        tmp_width = page.driver.browser.manage.window.size.width
        tmp_height = page.driver.browser.manage.window.size.height
        handle = ::Capybara.current_session.driver.current_window_handle

        page.driver.resize_window_to(handle, width, height)
        yield
        page.driver.resize_window_to(handle, tmp_width, tmp_height)
      end
    end
  end
end
