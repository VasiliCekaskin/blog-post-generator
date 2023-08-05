module App
  module BlogPostGenerator
    module BlogPostWriters
      class Disk
        class WriteError < StandardError
        end

        class << self
          def write_blog_post(blog_post:)
            new(blog_post: blog_post).write_blog_post
          end
        end

        def initialize(blog_post:)
          @blog_post = blog_post
        end

        def write_blog_post
          :ok
        end
      end
    end
  end
end
