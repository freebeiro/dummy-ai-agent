class Message < ApplicationRecord
  belongs_to :conversation
  after_create_commit { broadcast_append_to conversation, target: "messages", partial: "messages/message", locals: { message: self } }
end
