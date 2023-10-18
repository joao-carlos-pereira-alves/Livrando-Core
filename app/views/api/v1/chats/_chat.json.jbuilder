json.extract! chat, :id, :title, :created_at

last_message = chat.messages.last
another_user = chat.users.where.not(id: current_user.id).first

json.last_message last_message.body if last_message.present?
json.last_message_sent_date last_message.created_at if last_message.present? && last_message.user_id != current_user.id
json.number_of_unread_messages chat.messages.where.not(user_id: current_user.id).where(viewed: false).distinct.count
json.users chat.users, :id, :name
json.another_user_online another_user.online? if another_user.present?