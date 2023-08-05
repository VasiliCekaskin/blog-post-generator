require_relative './blog_post_prompt'

module App
  module BlogPostGenerator
    class BlogPost
      class << self
        def from_blog_post_prompt(blog_post_prompt:)
          blog_post_prompt_result = blog_post_prompt.prompt!

          new(
            blog_post_prompt_result.data[:title],
            blog_post_prompt_result.data[:author],
            blog_post_prompt_result.data[:date],
            blog_post_prompt_result.data[:tags],
            blog_post_prompt_result.data[:content],
            blog_post_prompt_result.data[:comments],
          )
        end
      end

      def initialize(title, author, date, tags, content, comments)
        @title = title
        @author = author
        @date = date
        @tags = tags
        @content = content
        @comments = comments
      end

      attr_reader :title, :author, :date, :tags, :content, :comments

      def save!(blog_post_writer:)
        blog_post_writer.write_blog_post(blog_post: self)
      end
    end
  end
end
