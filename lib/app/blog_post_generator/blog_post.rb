require_relative './blog_post_prompt'

module App
  module BlogPostGenerator
    class BlogPost
      class << self
        def from_blog_post_prompt(blog_post_prompt:)
          blog_post_prompt_result = blog_post_prompt.prompt!

          from_blog_post_prompt_result(blog_post_prompt_result)
        end

        def from_blog_post_prompt_result(blog_post_prompt_result)
          new(blog_post_prompt_result.data)
        end
      end

      def initialize(data)
        @title = data[:title]
        @author = data[:author]
        @date = data[:date]
        @tags = data[:tags]
        @content = data[:content]
        @comments = data[:comments]
      end

      attr_reader :title, :author, :date, :tags, :content, :comments

      def json
        Oj.dump({ title:, author:, date:, tags:, content:, comments: })
      end

      def save!(blog_post_writer:)
        blog_post_writer.write_blog_post(blog_post: self)
      end
    end
  end
end
