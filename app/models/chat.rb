class Chat < ApplicationRecord
  has_many :chat_users, dependent: :destroy
  has_many :messages,   dependent: :destroy
  has_many :users, through: :chat_users

  def self.initialize_trade(negotiator_id, sender_id, book_name)
    chat = Chat.find_or_create_by_users(negotiator_id, sender_id)
  
    sender_user = User.find(sender_id)
    message_text = "Olá, recebi sua solicitação de negociação do livro #{book_name}. Entrarei em contato assim que possível!"
  
    Message.create(chat_id: chat.id, user_id: sender_id, body: message_text)
  end

  def self.end_conversation(negotiator_id, sender_id, book_name)
    chat = Chat.find_or_create_by_users(negotiator_id, sender_id)

    sender_user = User.find(sender_id)
    message_text = "Negociação do livro #{book_name} concluída!"
  
    Message.create(chat_id: chat.id, user_id: sender_id, body: message_text)
  end

  def self.find_or_create_by_users(user1_id, user2_id)
    chat_user_ids = [user1_id, user2_id]

    chat = Chat.joins(:chat_users)
               .where(chat_users: { user_id: chat_user_ids })
               .group('chats.id')
               .having("COUNT(DISTINCT chat_users.user_id) = ?", chat_user_ids.size)
               .first

    unless chat.present?
      chat ||= create
      chat.add_users(chat_user_ids)
    end

    chat
  end

  def add_users(user_ids)
    user_ids.each do |user_id|
      ChatUser.create(chat_id: id, user_id: user_id)
    end
  end
end