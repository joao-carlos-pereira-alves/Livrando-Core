class Chat < ApplicationRecord
  has_many :chat_users, dependent: :destroy
  has_many :messages,   dependent: :destroy
  has_many :users, through: :chat_users

  def self.initialize_trade(negotiator_id, sender_id, book_name)
    chat = Chat.create

    ChatUser.create(chat_id: chat.id, user_id: negotiator_id)
    ChatUser.create(chat_id: chat.id, user_id: sender_id)

    sender_user = User.find(sender_id)
    message_text = "Tenho interesse no livro #{book_name}"

    Message.create(chat_id: chat.id, user_id: sender_id, body: message_text)
  end
end