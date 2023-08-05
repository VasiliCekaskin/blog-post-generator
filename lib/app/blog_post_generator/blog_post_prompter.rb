require_relative '../blog_post_generator/config'
require_relative '../logger'

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
        App::Logger.info('Prompting for blog post')

        prompt_client.prompt!(prompt: 'Some prompt')

        BlogPostPromptResult.new
      end

      private

      attr_reader :prompt_client
    end
  end
end
