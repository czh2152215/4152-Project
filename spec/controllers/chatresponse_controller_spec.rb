require 'rails_helper'

RSpec.describe ChatResponsesController, type: :controller do
  describe 'POST #create' do
    let(:valid_body) { { chatHistory: [{ role: 'user', content: 'Hello' }] }.to_json }
    let(:invalid_body) { {}.to_json }
    let(:openai_response) { { choices: [{ message: 'Response from OpenAI' }] } }

    before do
      allow(ENV).to receive(:fetch).with("OPENAI_ACCESS_TOKEN").and_return("mock_access_token")
      mock_client = double("OpenAI::Client")
      allow(OpenAI::Client).to receive(:new).and_return(mock_client)
      allow(mock_client).to receive(:chat).and_return(openai_response)
    end

    # context 'when the request is valid' do
    #   it 'returns a successful response from OpenAI' do
    #     post :create, body: valid_body
    #     puts response.body # Temporarily added for debugging purposes
    #     expect(response).to have_http_status(:ok)
    #     expect(JSON.parse(response.body)).to eq('Response from OpenAI')
    #   end
    # end

    context 'when the OpenAI API returns an error' do
      before do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_raise(StandardError)
      end

      it 'returns an unprocessable entity status' do
        post :create, body: valid_body
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the request body is invalid' do
      it 'handles invalid requests gracefully' do
        post :create, body: invalid_body
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
