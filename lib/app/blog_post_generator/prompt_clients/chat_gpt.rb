module App
  module BlogPostGenerator
    module PromptClients
      class ChatGPT
        class PromptError < StandardError
        end

        class << self
          def prompt!(prompt:)
          end
        end

        def initialize
        end
      end
    end
  end
end
