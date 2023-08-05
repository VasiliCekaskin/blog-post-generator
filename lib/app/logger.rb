module App
  class Logger
    class << self
      def info(message)
        puts message
      end
    end
  end
end
