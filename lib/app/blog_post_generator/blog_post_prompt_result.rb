# frozen_string_literal: true

require 'oj'

require_relative '../../prompt_clients/prompt_result'

module App
  module BlogPostGenerator
    class BlogPostPromptResult < PromptClients::PromptResult
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

        @data = {
          title: parsed_data[:title],
          author: parsed_data[:author],
          date: parsed_data[:date],
          tags: parsed_data[:tags],
          content: parsed_data[:content],
          comments: parsed_data[:comments]
        }
      end
    end
  end
end
