require_relative '../../../lib/app/blog_post_generator/blog_post'

RSpec.describe App::BlogPostGenerator::BlogPost do
  describe '.from_blog_post_prompt' do
    let(:blog_post_prompt) { App::BlogPostGenerator::BlogPostPrompt }

    it 'creates a blog post' do
      expect(blog_post_prompt).to receive(:prompt!).and_return(
        App::BlogPostGenerator::BlogPostPromptResult.new(
          { title: 'some title' },
        ),
      )

      expect(
        described_class.from_blog_post_prompt(blog_post_prompt:),
      ).to have_attributes({ title: 'some title' })
    end
  end

  describe '#save!' do
    subject(:blog_post) { described_class.new({ title: 'some title' }) }

    let(:blog_post_writer) { App::BlogPostGenerator::BlogPostWriters::Disk }

    it 'writes the blog post using the given writer' do
      expect(blog_post_writer).to receive(:write_blog_post).with(
        blog_post: blog_post,
      )

      blog_post.save!(blog_post_writer: blog_post_writer)
    end
  end
end
