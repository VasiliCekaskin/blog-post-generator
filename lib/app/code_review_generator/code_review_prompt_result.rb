# frozen_string_literal: true

require_relative '../../prompt_clients/prompt_result'

module App
  module CodeReviewGenerator
    class CodeReviewPromptResult < ::PromptClients::PromptResult
      class << self
        def from_prompt_result(prompt_result)
          blog_post_prompt_result = new(prompt_result.data)
          blog_post_prompt_result.transform!
          blog_post_prompt_result
        end
      end

      def transform!
        # parsed_data =
        #   Oj.load(@data['choices'][0]['message']['content'], symbol_keys: true)

        @data = {}
      end
    end
  end
end
