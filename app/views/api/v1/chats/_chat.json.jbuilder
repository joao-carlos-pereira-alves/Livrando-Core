<<<<<<< HEAD
json.extract! chat, :id, :title, :created_at, :updated_at
=======
json.extract! chat, :id, :title, :created_at

first_message = chat.messages.first

if first_message.present?
  json.last_message first_message.body
  json.last_message_sent_date first_message.created_at
end

json.number_of_unread_messages chat.messages.where.not(user_id: current_user.id).where(viewed: false).count

json.users! chat.users, :id, :name
>>>>>>> save-dev
