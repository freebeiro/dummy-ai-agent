class ChatsController < ApplicationController
  def show
    @conversation = Conversation.last || Conversation.create
    @messages = @conversation.messages.order(created_at: :asc)
    @products = DummyJsonService.fetch_products(limit: 5) # Fetch a few products for display
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender_type = "User" # Assuming user is sending the message

    if @message.save
      # Broadcasting will be handled by the model's callbacks after `broadcasts_to` is added.
      # For now, we just need to respond to the turbo-frame request.
      render turbo_stream: turbo_stream.replace(
        "new_message", # The ID of the turbo-frame to replace
        partial: "messages/form",
        locals: { conversation: @conversation, message: Message.new } # Reset form
      )
    else
      # Handle validation errors, perhaps re-render the form with errors
      # For PoC, keeping it simple. If save fails, the form won't reset.
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
