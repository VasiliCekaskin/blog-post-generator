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
