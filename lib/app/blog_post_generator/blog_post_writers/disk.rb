require_relative '../../logger'

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
          App::Logger.info('Writing new blog to disk')

          File.open("./blog_posts/#{blog_post.title}", 'w') do |file|
            file.write(blog_post.title)
          end

          App::Logger.info('Successfully wrote new blog to disk')
        end
      end
    end
  end
end
