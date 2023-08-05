require 'openai'
require 'oj'

require_relative '../config'

module App
  module BlogPostGenerator
    module PromptClients
      class ChatGPT
        class PromptError < StandardError
        end

        class << self
          def prompt!(prompt:)
            new(prompt).prompt!
          end
        end

        def initialize(prompt)
          @prompt = prompt
        end

        attr_reader :prompt

        def prompt!
          raw_prompt_result =
            openai_client.chat(
              parameters: {
                model: 'gpt-3.5-turbo',
                messages: [{ role: 'user', content: prompt }],
                temperature: 0.7,
              },
            )

          parsed_prompt_result =
            Oj.load(
              raw_prompt_result['choices'][0]['message']['content'],
              symbol_keys: true,
            )

          PromptResult.new(parsed_prompt_result)
        end

        private

        def openai_client
          @client ||=
            OpenAI::Client.new(access_token: Config.openai_access_token)
        end
      end
    end
  end
end
