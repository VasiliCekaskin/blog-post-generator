# frozen_string_literal: true

require_relative '../../../logger'
require_relative '../config'

module App
  module CodeReviewGenerator
    module CodeReviewWriters
      class Disk
        class WriteError < StandardError
        end

        class << self
          def write_code_review!(code_review:)
            new(code_review:).write_code_review
          end
        end

        def initialize(code_review:)
          @code_review = code_review
        end

        attr_reader :code_review

        def write_code_review
          Logger.info('Writing new code review to disk')

          File.open(code_reviews_path, 'w') do |file|
            file.write(code_review.json)
          end

          Logger.info(
            "Successfully wrote new code review to disk #{code_reviews_path}",
          )
        end

        def code_reviews_path
          "#{Config.code_reviews_path}/#{code_review.title}.json"
        end
      end
    end
  end
end
