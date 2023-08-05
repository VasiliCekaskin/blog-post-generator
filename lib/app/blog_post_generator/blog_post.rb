require_relative './blog_post_prompt'

module App
  module BlogPostGenerator
    class BlogPost
      class << self
        def from_blog_post_prompt(
          blog_post_prompt:,
          blog_post_prompt_result_parser:
        )
          blog_post_prompt_result = blog_post_prompt.prompt!

          blog_post_prompt_result_parser.build_blog_post(
            blog_post_prompt_result:,
            blog_class: self,
          )
        end
      end

      def initialize(title)
        @title = title
      end

      attr_reader :title

      def save!(blog_post_writer:)
        blog_post_writer.write_blog_post(blog_post: self.class)
      end
    end
  end
end
