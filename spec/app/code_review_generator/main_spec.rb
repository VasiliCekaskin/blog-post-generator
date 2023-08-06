# frozen_string_literal: true

require_relative '../../../lib/app/code_review_generator/main'
require_relative '../../../lib/app/code_review_generator/code_review_prompt_result'

RSpec.describe App::CodeReviewGenerator::Main do
  subject(:main) { described_class.new }

  describe '.run!' do
    let(:code_review) { instance_double(App::CodeReviewGenerator::CodeReview) }

    it 'Generates and writes a CodeReview' do
      expect(App::CodeReviewGenerator::CodeReview).to receive(
        :from_code_review_prompt
      ).with(
        code_review_prompt: App::CodeReviewGenerator::Config.code_review_prompt
      ).and_return(code_review)

      expect(code_review).to receive(:save!).with(
        code_review_writer: App::CodeReviewGenerator::Config.code_review_writer
      )

      main.generate_code_review!
    end
  end
end
