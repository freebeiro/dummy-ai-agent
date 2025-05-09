class ChatsController < ApplicationController
  def show
    if params[:new] == 'true'
      @conversation = Conversation.create
      # Redirect to the show page of the new conversation
      redirect_to conversation_path(@conversation) and return
    elsif params[:id]
      @conversation = Conversation.find(params[:id])
    else
      @conversation = Conversation.last || Conversation.create
    end
    
    @messages = @conversation.messages.order(created_at: :asc)
    @products = DummyJsonService.fetch_products(limit: 5) # Still needed for AI context
    @conversations_list = Conversation.order(updated_at: :desc).limit(10)
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender_type = "User"

    if @message.save
      # Fetch products for AI context
      products = DummyJsonService.fetch_products(limit: 5)
      product_list_summary = products.map { |p| "#{p['title']} ($#{p['price']})" }.join(', ')

      # Prepare conversation history for the AI service
      # We want to send all messages of the current conversation up to the new user message.
      # The new user message (@message) is already part of @conversation.messages once saved.
      # So, we fetch @conversation.messages.order(:created_at) which will include the latest user message.
      conversation_history_for_ai = @conversation.messages.order(created_at: :asc)

      # Get AI response
      ai_response_content = OpenAiService.get_chat_completion(conversation_history_for_ai, product_list_summary)

      # Create and save AI message
      if ai_response_content.present?
        ai_message = @conversation.messages.create(content: ai_response_content, sender_type: "AI")
        # AI message will be broadcast by its own after_create_commit callback

        # Check for order completion marker
        if ai_response_content.include?("ORDER_INFO_COMPLETE")
          # Simplified parsing for PoC: extract the summary part after the marker.
          # A more robust solution would parse structured data (e.g., JSON) if the AI provided it.
          order_summary_text = ai_response_content.split("ORDER_INFO_COMPLETE").last&.strip
          
          # For PoC, we'll just store the raw summary.
          # In a real app, you'd parse this into individual fields.
          Order.create(
            conversation: @conversation,
            product_details: order_summary_text || "Details not fully captured by AI.", # Fallback
            # Other fields like name, address would be parsed and set here
            # For now, we'll leave them blank or use placeholders if needed.
            first_name: "ParsedFirstName", # Placeholder
            last_name: "ParsedLastName",   # Placeholder
            email: "parsed@example.com", # Placeholder
            address: "Parsed Address",     # Placeholder
            postcode: "ParsedPostcode",  # Placeholder
            phone_number: "ParsedPhone"  # Placeholder
          )
          
          # Send a confirmation message
          confirmation_text = "Thank you! Your order has been simulated. Details: #{order_summary_text}"
          @conversation.messages.create(content: confirmation_text, sender_type: "System")
        end
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
