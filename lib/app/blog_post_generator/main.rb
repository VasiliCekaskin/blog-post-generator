require_relative '../blog_post_generator/config'

module App
  module BlogPostGenerator
    class Main
      class << self
        # Is this a good style?
        def run!
          new.generate while true
        end
      end

      def initialize(
        blog_post_prompter: Config.blog_post_prompter,
        blog_post_prompt_result_parser: Config.blog_post_prompt_result_parser,
        blog_post_writer: Config.blog_post_writer
      )
        @prompt_client = prompt_client
        @blog_post_prompt_result_parser = blog_post_prompt_result_parser
        @blog_post_writer = blog_post_writer
      end

      def generate!
        blog_post = generate_blog_post

        blog_post.save!(blog_post_writer:)
      end

      private

      attr_reader :prompt_client,
                  :blog_post_prompt_result_parser,
                  :blog_post_writer

      def generate_blog_post
        BlogPost.from_blog_post_prompt(
          blog_post_prompter:,
          blog_post_prompt_result_parser:,
        )
      end

      def blog_post_prompter
        @blog_post_prompter ||= BlogPostPrompter.new(prompt_client:)
      end
    end
  end
end
