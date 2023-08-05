require_relative '../../../lib/app/blog_post_generator/main'

RSpec.describe App::BlogPostGenerator::Main do
  let(:prompt_client) { App::BlogPostGenerator::PromptClients::ChatGPT.new }
  let(:blog_post_writer) do
    App::BlogPostGenerator::BlogPostWriters::Disk.new(blog_post:)
  end
  let(:blog_post_prompt_result_parser) do
    double(:blog_post_prompt_result_parser, parse: blog_post)
  end

  subject(:main) do
    described_class.new(
      prompt_client:,
      blog_post_prompt_result_parser:,
      blog_post_writer:,
    )
  end

  let(:prompt_client) { App::BlogPostGenerator::PromptClients::ChatGPT.new }
  let(:blog_post) { App::BlogPostGenerator::BlogPost.new }
  let(:blog_post_prompter) do
    App::BlogPostGenerator::BlogPostPrompter.new(prompt_client:)
  end
  let(:blog_post_prompt_result) do
    App::BlogPostGenerator::BlogPostPromptResult.new
  end

  describe '#run' do
    it 'creates blog_posts' do
      expect(App::BlogPostGenerator::BlogPostPrompter).to receive(:new).with(
        prompt_client:,
      ).and_return(blog_post_prompter)

      expect(blog_post_prompter).to receive(:prompt!).and_return(
        blog_post_prompt_result,
      )

      expect(App::BlogPostGenerator::BlogPost).to receive(
        :from_blog_post_prompt,
      ).with(
        blog_post_prompter:,
        blog_post_prompt_result:,
        blog_post_prompt_result_parser:,
        blog_post_writer:,
      ).and_return(blog_post)

      expect(blog_post).to receive(:save!)

      main.generate!
    end
  end
end
