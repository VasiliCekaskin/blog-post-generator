require_relative '../../../lib/app/blog_post_generator/blog_post_prompt_result'

RSpec.describe App::BlogPostGenerator::BlogPostPromptResult do
  describe '.from_prompt_result' do
    let(:prompt_result) do
      App::BlogPostGenerator::PromptResult.new('some raw prompt data')
    end

    it 'returns a blog post prompt result with data from prompt result' do
      expect(
        described_class.from_prompt_result(prompt_result),
      ).to have_attributes(data: prompt_result.data)
    end
  end
end
