require_relative '../../../lib/app/blog_post_generator/blog_post_prompt'

RSpec.describe App::BlogPostGenerator::BlogPostPrompt do
  describe '.prompt!' do
    let(:prompt_client) { App::BlogPostGenerator::Config.prompt_client }

    before { allow(File).to receive(:read).and_return('some prompt') }

    it 'prompts for a blog post' do
      expect(File).to receive(:read).and_return('some prompt')

      expect(prompt_client).to receive(:prompt!).with(
        prompt: 'some prompt',
      ).and_return(
        App::PromptResult.new(
          {
            'choices' => [
              {
                'message' => {
                  'content' => "#{Oj.dump({ title: 'some title' })}",
                },
              },
            ],
          },
        ),
      )

      described_class.prompt!
    end

    it 'returns a blog post prompt result' do
      expect(prompt_client).to receive(:prompt!).with(
        prompt: 'some prompt',
      ).and_return(
        App::PromptResult.new(
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
        ),
      )

      expect(described_class.prompt!).to have_attributes(
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
