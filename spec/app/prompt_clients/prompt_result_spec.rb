require_relative '../../../lib/prompt_clients/prompt_result'

RSpec.describe App::PromptClients::PromptResult do
  describe '#new' do
    it 'returns a prompt result' do
      expect(described_class.new('some raw prompt result')).to have_attributes(
        data: 'some raw prompt result',
      )
    end
  end
end
