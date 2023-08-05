require_relative '../blog_post_generator/config'

module App
  module BlogPostGenerator
    class BlogPostPrompter
      class << self
        def prompt!
          new.prompt!
        end
      end

      def initialize(prompt_client: Config.prompt_client)
        @prompt_client = prompt_client
      end

      def prompt!
        prompt_client.prompt!('Some prompt')
      end

      private

      attr_reader :prompt
    end
  end
end
