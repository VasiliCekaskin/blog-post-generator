# frozen_string_literal: true

require_relative '../../../../lib/app/code_review_generator/code_review_writers/disk'
require_relative '../../../../lib/app/code_review_generator/code_review'

RSpec.describe App::CodeReviewGenerator::CodeReviewWriters::Disk do
  subject(:disk) { described_class }

  describe '.write_code_review!' do
    let(:code_review) do
      instance_double(App::CodeReviewGenerator::CodeReview, title: 'some_title')
    end

    before { allow(File).to receive(:open) }

    it 'writes the code review to disk' do
      expect(File).to receive(:open).with(
        "#{App::CodeReviewGenerator::Config.code_reviews_path}/some_title",
        'w',
      )

      disk.write_code_review!(code_review:)
    end
  end
end
