# frozen_string_literal: true

require_relative '../../prompt_clients/chat_gpt'
require_relative './code_review_writers/disk'
require_relative './code_review_prompt'

module App
  module CodeReviewGenerator
    class Config
      class << self
        def prompts_path
          @prompts_path ||= File.join(__dir__, 'prompts')
        end

        def code_reviews_path
          @code_reviews_path ||= ENV.fetch('CODE_REVIEWS_PATH', nil)
        end

        def prompt_client
          @prompt_client ||= App::PromptClients::ChatGPT
        end

        def code_review_prompt
          @code_review_prompt ||= App::CodeReviewGenerator::CodeReviewPrompt
        end

        def code_review_writer
          @code_review_writer ||=
            App::CodeReviewGenerator::CodeReviewWriters::Disk
        end
      end
    end
  end
end
