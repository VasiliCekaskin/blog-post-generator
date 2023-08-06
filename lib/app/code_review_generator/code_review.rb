# frozen_string_literal: true
require 'securerandom'

module App
  module CodeReviewGenerator
    class CodeReview
      class << self
        def from_code_review_prompt(code_review_prompt:)
          code_review_prompt_result = code_review_prompt.prompt!

          new(code_review_prompt_result.data)
        end
      end

      def initialize(data)
        @data = data
        @title = SecureRandom.uuid
      end

      attr_reader :title

      def save!(code_review_writer:)
        code_review_writer.write_code_review!(code_review: self)
      end
    end
  end
end