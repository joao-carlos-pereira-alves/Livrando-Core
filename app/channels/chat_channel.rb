class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat_id = params[:chat_id]
    stream_from "chat_#{params[:chat_id]}"
  end

  def unsubscribed
    chat_id = params[:chat_id]
    stop_stream_from "chat_#{params[:chat_id]}"
  end

  def receive(data)
    chat_id             = params[:chat_id]
    body_message        = data.dig('body_message')
    another_user_online = data.dig('another_user_online')
    user_id             = data.dig('user_id')

    begin
      Message.create!(chat_id: chat_id, user_id: user_id, body: body_message)
      status_user_broadcast(chat_id, another_user_online) if another_user_online.present?
    rescue
      ActionCable.server.broadcast("chat_#{chat_id}", 'Bate papo temporariamente indisponível.')
    end
  end

  private

  def status_user_broadcast(chat_id, another_user_online)
    ActionCable.server.broadcast("chat_#{chat_id}", { another_user_online: another_user_online, type: 'user_status' })
  end
end
