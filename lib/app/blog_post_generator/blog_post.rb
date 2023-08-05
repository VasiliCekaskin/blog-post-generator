require_relative './blog_post_prompt'

module App
  module BlogPostGenerator
    class BlogPost
      class << self
        def from_blog_post_prompt(blog_post_prompt:)
          blog_post_prompt_result = blog_post_prompt.prompt!

          new(blog_post_prompt_result.data[:title])
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
