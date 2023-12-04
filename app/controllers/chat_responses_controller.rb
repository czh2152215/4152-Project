class ChatResponsesController < ApplicationController
  def create
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_ACCESS_TOKEN"))

    body = JSON.parse(request.body.read)
    chat_history = body['chatHistory'] # Assuming this is an array of message objects
    chat_history.map! { |message| message.transform_keys(&:to_sym) }

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo-1106",
        messages: [
          { role: "system", content: "You are a knowledgeable museum guide. Visitors are interested to learn about the artworks in the museum. Keep your responses under 120 words." },
          *chat_history
        ]
      }
    )
    print(response)
    if response.key?("choices")
      render json: response.dig("choices", 0, "message")
    else
      render json: { error: "Error processing the request" }, status: :unprocessable_entity
    end
  end
end
