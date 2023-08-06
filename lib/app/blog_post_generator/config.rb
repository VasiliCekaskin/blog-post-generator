# frozen_string_literal: true

require_relative '../../prompt_clients/chat_gpt'
require_relative 'blog_post_writers/disk'

require_relative 'blog_post'
require_relative 'blog_post_prompt'
require_relative 'blog_post_prompt_result'

module App
  module BlogPostGenerator
    class Config
      class << self
        def prompts_path
          @prompts_path ||= File.join(__dir__, 'prompts')
        end

        def blog_posts_path
          @blog_posts_path ||= ENV.fetch('BLOG_POSTS_PATH', nil)
        end

        def prompt_client
          @prompt_client ||= PromptClients::ChatGPT
        end

        def blog_post_prompt
          @blog_post_prompt ||=
            App::BlogPostGenerator::BlogPostPrompt
        end

        def blog_post_writer
          @blog_post_writer ||= App::BlogPostGenerator::BlogPostWriters::Disk
        end
      end
    end
  end
end
