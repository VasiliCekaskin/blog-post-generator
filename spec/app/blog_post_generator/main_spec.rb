# frozen_string_literal: true

require_relative '../../../lib/app/blog_post_generator/main'

RSpec.describe App::BlogPostGenerator::Main do
  subject(:main) { described_class.new }

  let(:blog_post) do
    instance_double(App::BlogPostGenerator::BlogPost, save!: nil)
  end

  describe '#run' do
    before do
      allow(App::BlogPostGenerator::BlogPost).to receive(
        :from_blog_post_prompt
      ).and_return(blog_post)

      allow(blog_post).to receive(:save!).with(
        blog_post_writer: App::BlogPostGenerator::Config.blog_post_writer
      )
    end

    it 'creates blog_posts' do
      expect(App::BlogPostGenerator::BlogPost).to receive(
        :from_blog_post_prompt
      ).with(
        blog_post_prompt: App::BlogPostGenerator::Config.blog_post_prompt
      ).and_return(blog_post)

      expect(blog_post).to receive(:save!).with(
        blog_post_writer: App::BlogPostGenerator::Config.blog_post_writer
      )

      main.generate_blog!
    end

    context 'with error during prompt client request' do
      it 'logs the error' do
        allow(App::BlogPostGenerator::BlogPost).to receive(
          :from_blog_post_prompt
        ).and_raise(PromptClients::ChatGPT::PromptError)

        expect(Logger).to receive(:error).with(
          PromptClients::ChatGPT::PromptError
        )

        main.generate_blog!
      end
    end

    context 'with error during prompt writing' do
      it 'logs the error' do
        allow(App::BlogPostGenerator::BlogPost).to receive(
          :from_blog_post_prompt
        ).and_raise(App::BlogPostGenerator::BlogPostWriters::Disk::WriteError)

        expect(Logger).to receive(:error).with(
          App::BlogPostGenerator::BlogPostWriters::Disk::WriteError
        )

        main.generate_blog!
      end
    end
  end
end
