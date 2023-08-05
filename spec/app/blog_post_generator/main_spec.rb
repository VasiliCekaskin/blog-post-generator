require_relative '../../../lib/app/blog_post_generator/main'

RSpec.describe App::BlogPostGenerator::Main do
  subject(:main) { described_class.new }

  let(:blog_post) do
    instance_double(App::BlogPostGenerator::BlogPost, save!: nil)
  end
  let(:blog_post_prompt_result) do
    instance_double(App::BlogPostGenerator::BlogPostPromptResult)
  end

  describe '#run' do
    it 'creates blog_posts' do
      expect(App::BlogPostGenerator::BlogPost).to receive(
        :from_blog_post_prompt,
      ).with(
        blog_post_prompter: App::BlogPostGenerator::Config.blog_post_prompter,
        blog_post_prompt_result_parser:
          App::BlogPostGenerator::Config.blog_post_prompt_result_parser,
      ).and_return(blog_post)

      expect(blog_post).to receive(:save!).with(
        blog_post_writer: App::BlogPostGenerator::Config.blog_post_writer,
      )

      main.generate!
    end
  end
end
