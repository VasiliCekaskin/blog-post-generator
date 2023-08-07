# frozen_string_literal: true

require_relative '../blog_post_generator/config'
require_relative '../../logger'

module App
  module BlogPostGenerator
    class BlogPostPrompt
      @@topics = []

      class << self
        def prompt!
          new.prompt!
        end
      end

      def initialize(prompt_client: Config.prompt_client)
        @prompt_client = prompt_client
      end

      def prompt!
        Logger.info('Prompting for blog post')

        blog_topic = prompt_for_blog_topic

        Logger.info("Blog topic: #{blog_topic}")

        blog_style = prompt_for_blog_style(blog_topic)

        Logger.info("Blog style: #{blog_style}")

        prompt = File.read("#{Config.prompts_path}/blog_post_prompt")

        prompt.gsub!('[blog_topic]', blog_topic)
        prompt.gsub!('[blog_style]', blog_style)

        prompt_result = prompt_client.prompt!(prompt:)
        BlogPostPromptResult.from_prompt_result(prompt_result)
      end

      private

      attr_reader :prompt_client

      def prompt_for_blog_style(blog_topic)
        prompt_result =
          prompt_client.prompt!(
            prompt:
              "You are an assistant who does exactly as I say. \n
               Answer only in one word. Suggest a writing style for a \n
               blog post about following topic: #{blog_topic}",
          )

        style = parse_raw_prompt_result(prompt_result)

        style
      end

      def prompt_for_blog_topic
        prompt_result =
          prompt_client.prompt!(
            prompt:
              "Give me a random blog post topic. Do not give following suggestions: #{@@topics}",
          )

        topic = parse_raw_prompt_result(prompt_result)

        @@topics.push(topic)

        topic
      end

      def parse_raw_prompt_result(prompt_result)
        prompt_result.data['choices'][0]['message']['content']
      end
    end
  end
end
