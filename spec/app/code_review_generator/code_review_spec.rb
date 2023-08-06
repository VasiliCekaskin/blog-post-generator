# frozen_string_literal: true

require_relative '../../../lib/app/code_review_generator/code_review'
require_relative '../../../lib/app/code_review_generator/code_review_prompt_result'
require_relative '../../../lib/app/code_review_generator/code_review_writers/disk'

RSpec.describe App::CodeReviewGenerator::CodeReview do
  describe '.from_code_review_prompt' do
    let(:code_review_prompt) { App::CodeReviewGenerator::CodeReviewPrompt }

    it 'creates a blog post' do
      expect(code_review_prompt).to receive(:prompt!).and_return(
        App::CodeReviewGenerator::CodeReviewPromptResult.new('some data'),
      )

      expect(
        described_class.from_code_review_prompt(code_review_prompt:),
      ).to have_attributes({})
    end
  end

  describe '#save!' do
    subject(:code_review) { described_class.new({ title: 'some title' }) }

    let(:code_review_writer) do
      App::CodeReviewGenerator::CodeReviewWriters::Disk
    end

    it 'writes the blog post using the given writer' do
      expect(code_review_writer).to receive(:write_code_review!).with(
        code_review:,
      )

      code_review.save!(code_review_writer:)
    end
  end
end
