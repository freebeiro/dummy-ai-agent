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

      Your tasks:
      1. Respond to the user's message. If they ask about products, use the provided list.
      2. If the user expresses clear intent to buy or order a product (e.g., "I want to buy this", "I'd like to order", "checkout"), guide them through collecting order information.
      3. Order information needed:
         - Full Name
         - Shipping Address
         - Email Address
         - Phone Number
         - Product(s) they want to order (confirm from the available list)
         - Quantity for each product
      4. Ask for one piece of information at a time, or a couple of related ones (e.g., name and email).
      5. Once you believe you have collected all necessary information, clearly state "ORDER_INFO_COMPLETE" on a new line, followed by a summary of the collected details in a structured format (e.g., "Name: John Doe, Email: john@example.com, ...").
      6. Keep your responses concise, friendly, and focused on the task.
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
