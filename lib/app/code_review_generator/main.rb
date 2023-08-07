# frozen_string_literal: true

require_relative '../../logger'
require_relative './config'
require_relative './code_review'

module App
  module CodeReviewGenerator
    class Main
      class << self
        def run!
          code_review_generator = new

          loop { code_review_generator.generate_code_review! }
        end
      end

      def initialize(
        code_review_prompt: Config.code_review_prompt,
        code_review_writer: Config.code_review_writer
      )
        @code_review_prompt = code_review_prompt
        @code_review_writer = code_review_writer
      end

      def generate_code_review!
        generate_and_save!
      end

      private

      attr_reader :code_review_prompt, :code_review_writer

      def generate_and_save!
        code_review_prompt_result = code_review_prompt.prompt!

        CodeReview.from_code_review_prompt_result(
          code_review_prompt_result:,
        ).save!(code_review_writer:)
      rescue StandardError => e
        Logger.error(e)
        raise e
      end
    end
  end
end
