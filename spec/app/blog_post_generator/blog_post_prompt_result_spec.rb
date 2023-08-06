require_relative '../../../lib/app/blog_post_generator/blog_post_prompt_result'

RSpec.describe App::BlogPostGenerator::BlogPostPromptResult do
  describe '.from_prompt_result' do
    let(:prompt_result) do
      App::BlogPostGenerator::PromptResult.new(
        {
          'choices' => [
            {
              'message' => {
                'content' => "#{Oj.dump({ title: 'some title' })}",
              },
            },
          ],
        },
      )
    end

    it 'returns blog post with transformed data' do
      expect(
        described_class.from_prompt_result(prompt_result),
      ).to have_attributes({ data: { title: 'some title' } })
    end
  end
end
