require_relative '../../../../lib/app/blog_post_generator/prompt_clients/chat_gpt'

RSpec.describe App::BlogPostGenerator::PromptClients::ChatGPT do
  describe '.prompt!' do
    let(:prompt) { 'some prompt' }
    it 'prompts the given prompt' do
      chat_gpt.prompt!(prompt:)
    end
  end
end
