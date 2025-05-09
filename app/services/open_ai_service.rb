require 'openai'

class OpenAiService
  def self.client
    OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY', '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'))
  end

  def self.get_chat_completion(user_message, product_list_summary)
    prompt = <<~PROMPT
      You are a helpful e-commerce assistant for 'DummyShop'.
      The user said: "#{user_message}"
      Available products: #{product_list_summary}.
      Respond to the user's message. If they ask about products, use the provided list.
      Keep your responses concise and friendly.
    PROMPT

    begin
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: prompt }],
          temperature: 0.7
        }
      )
      response.dig("choices", 0, "message", "content")
    rescue OpenAI::Error => e
      Rails.logger.error "OpenAI API Error: #{e.message}"
      "Sorry, I'm having trouble connecting to my brain right now. Please try again later."
    rescue StandardError => e
      Rails.logger.error "OpenAI Service Standard Error: #{e.message}"
      "An unexpected error occurred. Please try again."
    end
  end
end
