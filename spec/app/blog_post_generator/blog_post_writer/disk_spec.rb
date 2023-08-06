require_relative '../../../../lib/app/blog_post_generator/blog_post_writers/disk'
require_relative '../../../../lib/app/blog_post_generator/blog_post'

RSpec.describe App::BlogPostGenerator::BlogPostWriters::Disk do
  subject(:disk) { described_class }

  describe '.write_blog_post' do
    let(:blog_post) do
      instance_double(
        App::BlogPostGenerator::BlogPost,
        title: 'some_title',
        json: 'some json',
      )
    end

    before { allow(File).to receive(:open) }

    it 'writes the blog post to disk' do
      expect(File).to receive(:open).with(
        "#{App::BlogPostGenerator::Config.blog_posts_path}/some_title.json",
        'w',
      )

      disk.write_blog_post(blog_post:)
    end
  end
end
