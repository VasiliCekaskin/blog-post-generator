# frozen_string_literal: true

require_relative './config'
require_relative '../../logger'
require_relative './code_review_prompt_result'

module App
  module CodeReviewGenerator
    class CodeReviewPrompt
      class << self
        def prompt!
          new.prompt!
        end
      end

      def initialize(prompt_client: Config.prompt_client)
        @prompt_client = prompt_client
      end

      def prompt!
        Logger.info('Prompting for code review')

        prompt = File.read("#{Config.prompts_path}/code_review_prompt")

        prompt_result = prompt_client.prompt!(prompt:)

        CodeReviewPromptResult.from_prompt_result(prompt_result)
      end

      private

      attr_reader :prompt_client
    end
  end
end
