module App
  module BlogPostGenerator
    class BlogPost
      class << self
        def from_blog_post_prompt(
          blog_post_prompter:,
          blog_post_prompt_result_parser:
        )
          blog_post_prompt_result = blog_post_prompter.prompt!

          blog_post_prompt_result_parser.build_blog_post(
            blog_post_prompt_result:,
            blog_class: self.class,
          )
        end
      end

      def initialize(title)
        @title = title
      end

      attr_reader :title

      def save!(blog_post_writer:)
        blog_post_writer.write_blog_post(blog_post: self)
      end
    end
  end
end
