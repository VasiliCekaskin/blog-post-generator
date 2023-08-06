# frozen_string_literal: true

# A new prompt client should adhere to the same interface as the old prompt client.

module PromptClients
  class PromptResult
    def initialize(data)
      @data = data
    end

    attr_reader :data
  end
end
