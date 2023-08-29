class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  after_create_commit :send_message_for_broadcast

  private

  def send_message_for_broadcast
    ActionCable.server.broadcast("chat_#{chat_id}", body)
  end
end
