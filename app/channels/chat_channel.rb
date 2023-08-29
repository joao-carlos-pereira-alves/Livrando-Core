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
    chat_id      = params[:chat_id]
    body_message = data.dig('body_message')
    user_id      = data.dig('user_id')

    begin
      Message.create!(chat_id: chat_id, user_id: user_id, body: body_message)
    rescue
      ActionCable.server.broadcast("chat_#{chat_id}", 'Bate papo temporariamente indisponível.')
    end
  end
end
