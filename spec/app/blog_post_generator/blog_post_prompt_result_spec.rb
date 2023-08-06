require_relative '../../../lib/app/blog_post_generator/blog_post_prompt_result'

RSpec.describe App::BlogPostGenerator::BlogPostPromptResult do
  describe '.from_prompt_result' do
    let(:prompt_result) do
      App::PromptClients::PromptResult.new(
        {
          'choices' => [
            {
              'message' => {
                'content' =>
                  "#{
                    Oj.dump(
                      {
                        title: 'some title',
                        author: 'some author',
                        date: 'some date',
                        tags: 'some tags',
                        content: 'some content',
                        comments: 'some comments',
                      },
                    )
                  }",
              },
            },
          ],
        },
      )
    end

    it 'returns blog post with transformed data' do
      expect(
        described_class.from_prompt_result(prompt_result),
      ).to have_attributes(
        {
          data: {
            title: 'some title',
            author: 'some author',
            date: 'some date',
            tags: 'some tags',
            content: 'some content',
            comments: 'some comments',
          },
        },
      )
    end
  end
end
