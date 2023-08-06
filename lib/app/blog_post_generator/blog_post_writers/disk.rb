# frozen_string_literal: true

require_relative '../../../logger'
require_relative '../config'

module App
  module BlogPostGenerator
    module BlogPostWriters
      class Disk
        class WriteError < StandardError
        end

        class << self
          def write_blog_post(blog_post:)
            new(blog_post:).write_blog_post
          end
        end

        def initialize(blog_post:)
          @blog_post = blog_post
        end

        attr_reader :blog_post

        def write_blog_post
          Logger.info('Writing new blog to disk')

          File.open(blog_post_path, 'w') { |_file| blog_post.json }

          Logger.info("Successfully wrote new blog to disk #{blog_post_path}")
        end

        def blog_post_path
          "#{Config.blog_posts_path}/#{blog_post.title}.json"
        end
      end
    end
  end
end
