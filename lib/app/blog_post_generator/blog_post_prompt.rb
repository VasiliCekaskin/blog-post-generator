require_relative '../blog_post_generator/config'
require_relative '../logger'

module App
  module BlogPostGenerator
    class BlogPostPrompt
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

        prompt = File.read("#{__dir__}/prompts/blog_post_prompt")
        prompt_result = prompt_client.prompt!(prompt:)
        BlogPostPromptResult.from_prompt_result(prompt_result)
      end

      private

      attr_reader :prompt_client
    end
  end
end
