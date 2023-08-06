# frozen_string_literal: true

require_relative '../../../lib/app/code_review_generator/main'
require_relative '../../../lib/app/code_review_generator/code_review_prompt_result'

RSpec.describe App::CodeReviewGenerator::Main do
  subject(:main) { described_class.new }

  describe '.run!' do
    let(:code_review) { instance_double(App::CodeReviewGenerator::CodeReview) }
    let(:code_review_prompt_result) do
      App::CodeReviewGenerator::CodeReviewPromptResult.new('some data')
    end

    it 'Generates and writes a CodeReview' do
      expect(App::CodeReviewGenerator::Config.code_review_prompt).to receive(
        :prompt!,
      ).and_return(code_review_prompt_result)

      expect(App::CodeReviewGenerator::CodeReview).to receive(
        :from_code_review_prompt_result,
      ).with(code_review_prompt_result:).and_return(code_review)

      expect(code_review).to receive(:save!).with(
        code_review_writer: App::CodeReviewGenerator::Config.code_review_writer,
      )

      main.generate_code_review!
    end
  end
end
