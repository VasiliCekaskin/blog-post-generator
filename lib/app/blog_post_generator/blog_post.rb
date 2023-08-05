module App
  module BlogPostGenerator
    class BlogPost
      class << self
        def from_blog_post_prompt(
          blog_post_prompter:,
          blog_post_prompt_result:,
          blog_post_prompt_result_parser:,
          blog_post_writer:
        )
        end
      end

      def initialize
      end

      def save!
        :ok
      end
    end
  end
end
