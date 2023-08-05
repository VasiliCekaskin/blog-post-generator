require_relative '../../../../lib/app/blog_post_generator/prompt_clients/chat_gpt'

RSpec.describe App::BlogPostGenerator::PromptClients::ChatGPT do
  subject(:chat_gpt_prompt_client) { described_class }

  describe '.prompt!' do
    let(:prompt) { 'some prompt' }
    let(:openai_client) { instance_double(OpenAI::Client) }

    before do
      allow(OpenAI::Client).to receive(:new).with(
        access_token: App::BlogPostGenerator::Config.openai_access_token,
      ).and_return(openai_client)

      allow(openai_client).to receive(:chat).and_return(
        {
          'choices' => [
            {
              'message' => {
                'content' => "#{Oj.dump({ title: 'some title' })}",
              },
            },
          ],
        },
      )
    end

    it 'prompts the given prompt' do
      chat_gpt_prompt_client.prompt!(prompt:)

      expect(openai_client).to have_received(:chat).with(
        {
          parameters: {
            model: 'gpt-3.5-turbo',
            messages: [{ role: 'user', content: prompt }],
            temperature: 0.7,
          },
        },
      )
    end

    it 'returns a prompt result with data of the response' do
      expect(chat_gpt_prompt_client.prompt!(prompt:)).to have_attributes(
        { data: { title: 'some title' } },
      )
    end
  end
end
