class AddChannelToChatMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :chat_messages, :channel, foreign_key: true
  end
end
