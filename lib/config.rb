# frozen_string_literal: true

class Config
  class << self
    def openai_access_token
      ENV.fetch('OPENAI_ACCESS_TOKEN', nil)
    end
  end
end
