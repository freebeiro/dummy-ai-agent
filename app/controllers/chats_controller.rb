class ChatsController < ApplicationController
  def show
    @conversation = Conversation.last || Conversation.create
    @messages = @conversation.messages.order(created_at: :asc)
  end
end
