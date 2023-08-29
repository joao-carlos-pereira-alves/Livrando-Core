class ChatChannel < ApplicationCable::Channel
  def subscribed
    chat_id = params[:chat_id]
    stream_from "chat_#{params[:chat_id]}"
  end

  def unsubscribed
    chat_id = params[:chat_id]
    stop_stream_from "chat_#{params[:chat_id]}"
  end
end
