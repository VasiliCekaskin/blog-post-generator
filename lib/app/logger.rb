module App
  class Logger
    class << self
      def info(message)
        puts "Info: |- #{message} -|"
      end

      def error(message)
        puts "Error: |!! #{message} !!|"
      end
    end
  end
end
