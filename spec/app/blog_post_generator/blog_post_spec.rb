require_relative '../../../lib/app/blog_post_generator/blog_post'

RSpec.describe App::BlogPostGenerator::BlogPost do
  describe '#from_blog_post_prompt' do
    let(:expected_blog_post) do
      instance_double(App::BlogPostGenerator::BlogPost)
    end
    let(:blog_post_prompt) { App::BlogPostGenerator::BlogPostPrompt }

    let(:blog_post_prompt_result_parser) do
      App::BlogPostGenerator::BlogPostPromptResultParser
    end

    it 'creates a blog post using the given prompt and result parser' do
      expect(blog_post_prompt).to receive(:prompt!).and_return('prompt result')
      expect(blog_post_prompt_result_parser).to receive(:build_blog_post).with(
        blog_post_prompt_result: 'prompt result',
        blog_class: described_class,
      ).and_return(expected_blog_post)

      expect(
        described_class.from_blog_post_prompt(
          blog_post_prompt:,
          blog_post_prompt_result_parser:,
        ),
      ).to be(expected_blog_post)
    end
  end
end
