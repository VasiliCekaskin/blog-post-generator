require 'oj'

require_relative './prompt_result'

module App
  module BlogPostGenerator
    class BlogPostPromptResult < PromptResult
      class << self
        def from_prompt_result(prompt_result)
          blog_post_prompt_result = new(prompt_result.data)
          blog_post_prompt_result.transform!
          blog_post_prompt_result
        end
      end

      def transform!
        parsed_data =
          Oj.load(@data['choices'][0]['message']['content'], symbol_keys: true)

        @data = { title: parsed_data[:title] }
      end
    end
  end
end
