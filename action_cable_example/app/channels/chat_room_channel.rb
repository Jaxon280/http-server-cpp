class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_from_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    ActionCable.server.broadcast 'chat_room_channel', message: data['message']
  end
end
