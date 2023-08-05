module App
  module BlogPostGenerator
    class BlogPostPrompter
      def initialize(prompt_client:, prompt: 'Write a blog post')
        @prompt_client = prompt_client
        @prompt = prompt
      end

      def prompt!
        prompt_client_result = prompt_client.prompt!(prompt:)
      end

      private

      attr_reader :prompt
    end
  end
end
