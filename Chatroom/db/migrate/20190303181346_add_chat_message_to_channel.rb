class AddChatMessageToChannel < ActiveRecord::Migration[5.2]
  def change
    add_reference :channels, :chat_message, foreign_key: true
  end
end
