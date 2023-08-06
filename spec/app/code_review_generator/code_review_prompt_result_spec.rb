# frozen_string_literal: true

require_relative '../../../lib/prompt_clients/prompt_result'
require_relative '../../../lib/app/code_review_generator/code_review_prompt_result'

RSpec.describe App::CodeReviewGenerator::CodeReviewPromptResult do
  subject(:code_review_prompt) { described_class }
  describe '.from_prompt_result' do
    it 'returns a CodeReviewPromptResult from a generic prompt result' do
      expect(
        code_review_prompt.from_prompt_result(
          PromptClients::PromptResult.new(
            {
              'choices' => [
                {
                  'message' => {
                    'content' =>
                      Oj.dump(
                        {
                          title: 'some title',
                          code_actions: [
                            {
                              file_path: 'lib/app/file.rb',
                              new_code: 'some new file code',
                            },
                          ],
                        },
                      ),
                  },
                },
              ],
            },
          ),
        ),
      ).to have_attributes(
        {
          data: {
            title: 'some title',
            code_actions: [
              { file_path: 'lib/app/file.rb', new_code: 'some new file code' },
            ],
          },
        },
      )
    end
  end
end
