module App
  class Logger
    class << self
      def error(message)
        puts message
      end
    end
  end
end
