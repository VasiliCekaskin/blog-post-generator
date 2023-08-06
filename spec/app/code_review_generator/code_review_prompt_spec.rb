# frozen_string_literal: true

require_relative '../../../lib/app/code_review_generator/code_review_prompt'
require_relative '../../../lib/prompt_clients/prompt_result'

RSpec.describe App::CodeReviewGenerator::CodeReviewPrompt do
  describe '.prompt!' do
    let(:prompt_client) { App::CodeReviewGenerator::Config.prompt_client }
    let(:prompt_result) do
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
      )
    end

    before do
      allow(File).to receive(:read).with(
        "#{App::CodeReviewGenerator::Config.prompts_path}/code_review_prompt",
      ).and_return('some prompt')
    end

    it 'prompts for a code review' do
      expect(File).to receive(:read).with(
        "#{App::CodeReviewGenerator::Config.prompts_path}/code_review_prompt",
      ).and_return('some prompt')

      expect(prompt_client).to receive(:prompt!).with(
        prompt: 'some prompt',
      ).and_return(prompt_result)

      described_class.prompt!
    end

    it 'returns a blog post prompt result' do
      expect(prompt_client).to receive(:prompt!).with(
        prompt: 'some prompt',
      ).and_return(prompt_result)

      expect(described_class.prompt!).to have_attributes(
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
