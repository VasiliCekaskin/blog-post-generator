# frozen_string_literal: true
require 'securerandom'
require 'oj'

module App
  module CodeReviewGenerator
    class CodeReview
      class << self
        def from_code_review_prompt_result(code_review_prompt_result:)
          new(code_review_prompt_result.data)
        end
      end

      def initialize(data)
        @title = data[:title]
        @code_actions = data[:code_actions]
      end

      def json
        Oj.dump({ title: title, code_actions: code_actions })
      end

      attr_reader :title, :code_actions

      def save!(code_review_writer:)
        code_review_writer.write_code_review!(code_review: self)
      end
    end
  end
end
