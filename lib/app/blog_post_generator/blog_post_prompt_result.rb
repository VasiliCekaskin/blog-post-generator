module App
  module BlogPostGenerator
    class BlogPostPromptResult
      def initialize(ok:, data:)
        @ok = ok
        @data = data
      end

      attr_reader :ok, :data
    end
  end
end
