module App
  module BlogPostGenerator
    class BlogPostPromptResultParser
      class << self
        def build_blog_post(blog_post_prompt_result:, blog_class:)
          new(blog_post_prompt_result, blog_class).build_blog_post
        end
      end

      def initialize(blog_post_prompt_result, blog_class)
        @blog_post_prompt_result = blog_post_prompt_result
        @blog_class = blog_class
      end

      def build_blog_post
        blog_class.new('some blog info')
      end
    end
  end
end
