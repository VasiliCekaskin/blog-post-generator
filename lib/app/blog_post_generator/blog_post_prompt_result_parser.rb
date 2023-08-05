require_relative '../logger'

module App
  module BlogPostGenerator
    class BlogPostPromptResultParser
      class ParseError < StandardError
      end

      class << self
        def build_blog_post(blog_post_prompt_result:, blog_class:)
          App::Logger.info(
            "Building blog post from #{blog_post_prompt_result} to #{blog_class}",
          )
          new(blog_post_prompt_result, blog_class).build_blog_post
        end
      end

      attr :blog_class

      def initialize(blog_post_prompt_result, blog_class)
        @blog_post_prompt_result = blog_post_prompt_result
        @blog_class = blog_class
      end

      def build_blog_post
        blog_class.new('Some blog title')
      end
    end
  end
end
