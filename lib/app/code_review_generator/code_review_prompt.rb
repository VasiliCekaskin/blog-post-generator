# frozen_string_literal: true
require 'oj'

require_relative './config'
require_relative '../../logger'
require_relative './code_review_prompt_result'

module App
  module CodeReviewGenerator
    class CodeReviewPrompt
      class << self
        def prompt!
          new.prompt!
        end
      end

      def initialize(prompt_client: Config.prompt_client)
        @prompt_client = prompt_client
      end

      def prompt!
        Logger.info('Prompting for code review')

        prompt = File.read("#{Config.prompts_path}/code_review_prompt")

        prompt.gsub!('[code_base_info]', Oj.dump(code_base_info))

        prompt_result = prompt_client.prompt!(prompt:)

        CodeReviewPromptResult.from_prompt_result(prompt_result)
      end

      private

      attr_reader :prompt_client

      def code_base_info
        files_hash = read_files_recursively('./lib')

        files_hash
      end

      def read_gitignore(directory)
        gitignore_path = File.join(directory, '.gitignore')
        return [] unless File.exist?(gitignore_path)

        gitignore_patterns = File.read(gitignore_path).split("\n").map(&:strip)
        gitignore_patterns.reject! do |pattern|
          pattern.empty? || pattern.start_with?('#')
        end

        gitignore_patterns
      end

      def read_files_recursively(directory)
        gitignore_patterns = read_gitignore(directory)
        files_content = {}

        Dir.foreach(directory) do |entry|
          next if entry == '.' || entry == '..'

          full_path = File.join(directory, entry)

          if File.directory?(full_path) &&
               (entry == '.git' || entry == 'node_modules' || entry == 'output')
            next
          end

          if gitignore_patterns.any? { |pattern|
               File.fnmatch?(pattern, full_path)
             }
            next
          end

          if File.directory?(full_path)
            # If the entry is a subdirectory, recursively read its files
            files_content.merge!(read_files_recursively(full_path))
          else
            # If the entry is a file, read its content and add it to the hash
            files_content[full_path] = File.read(full_path)
          end
        end

        files_content
      end
    end
  end
end
