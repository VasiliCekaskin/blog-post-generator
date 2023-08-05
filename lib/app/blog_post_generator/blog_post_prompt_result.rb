require_relative './prompt_result'

module App
  module BlogPostGenerator
    class BlogPostPromptResult < PromptResult
      class << self
        def from_prompt_result(prompt_result)
          new(prompt_result.data)
        end
      end
    end
  end
end
