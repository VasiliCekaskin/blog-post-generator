# frozen_string_literal: true

require_relative '../../../lib/app/code_review_generator/code_review'
require_relative '../../../lib/app/code_review_generator/code_review_prompt_result'
require_relative '../../../lib/app/code_review_generator/code_review_writers/disk'

RSpec.describe App::CodeReviewGenerator::CodeReview do
  subject(:code_review) { described_class }
  describe '.from_code_review_prompt_result' do
    let(:code_review_prompt) { App::CodeReviewGenerator::CodeReviewPrompt }
    let(:code_review_prompt_result) do
      App::CodeReviewGenerator::CodeReviewPromptResult.new(
        {
          title: 'some title',
          code_actions: [
            { file_path: 'lib/app/file.rb', new_code: 'some new file code' },
          ],
        },
      )
    end

    it 'creates a blog post' do
      expect(
        code_review.from_code_review_prompt_result(code_review_prompt_result:),
      ).to have_attributes(
        {
          title: 'some title',
          code_actions: [
            { file_path: 'lib/app/file.rb', new_code: 'some new file code' },
          ],
        },
      )
    end
  end

  describe '#json' do
    subject(:code_review) do
      described_class.new(
        {
          title: 'some title',
          code_actions: [
            { file_path: 'lib/app/config.rb', new_code: 'some new code' },
          ],
        },
      )
    end

    it 'returns json representation of the blog post' do
      expect(Oj.load(code_review.json, symbol_keys: true)).to eq(
        {
          title: 'some title',
          code_actions: [
            { file_path: 'lib/app/config.rb', new_code: 'some new code' },
          ],
        },
      )
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
