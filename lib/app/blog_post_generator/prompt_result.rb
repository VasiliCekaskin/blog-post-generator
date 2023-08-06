# A new prompt client should adhere to the same interface as the old prompt client.

module App
  module BlogPostGenerator
    class PromptResult
      def initialize(data)
        @data = data
      end

      attr_reader :data
    end
  end
end
