require_relative '../blog_post_generator/config'
require_relative '../../logger'

module App
  module BlogPostGenerator
    class Main
      class << self
        def run!
          blog_post_generator = new

          blog_post_generator.generate_blog! while true
        end
      end

      def initialize(
        blog_post_prompt: Config.blog_post_prompt,
        blog_post_writer: Config.blog_post_writer
      )
        @blog_post_prompt = blog_post_prompt
        @blog_post_writer = blog_post_writer
      end

      def generate_blog!
        generate_and_save!
      end

      private

      attr_reader :blog_post_prompt,
                  :blog_post_prompt_result_parser,
                  :blog_post_writer

      def generate_and_save!
        BlogPost.from_blog_post_prompt(blog_post_prompt:).save!(
          blog_post_writer:,
        )
      rescue StandardError => e
        Logger.error(e)
        raise e
      end
    end
  end
end
