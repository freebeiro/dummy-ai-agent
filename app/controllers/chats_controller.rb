class ChatsController < ApplicationController
  def show
    @conversation = Conversation.last || Conversation.create
    @messages = @conversation.messages.order(created_at: :asc)
    @products = DummyJsonService.fetch_products(limit: 5) # Fetch a few products for display
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender_type = "User"

    if @message.save
      # Fetch products for AI context
      products = DummyJsonService.fetch_products(limit: 5)
      product_list_summary = products.map { |p| "#{p['title']} ($#{p['price']})" }.join(', ')

      # Get AI response
      ai_response_content = OpenAiService.get_chat_completion(@message.content, product_list_summary)

      # Create and save AI message
      if ai_response_content.present?
        ai_message = @conversation.messages.create(content: ai_response_content, sender_type: "AI")
        # AI message will be broadcast by its own after_create_commit callback
      end

      # Respond to the turbo-frame request for the user's message form
      render turbo_stream: turbo_stream.replace(
        "new_message",
        partial: "messages/form",
        locals: { conversation: @conversation, message: Message.new } # Reset form
      )
    else
      # Handle validation errors for user's message
      render turbo_stream: turbo_stream.replace(
        "new_message",
        partial: "messages/form",
        locals: { conversation: @conversation, message: @message } # Show errors
      )
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
