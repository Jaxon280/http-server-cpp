class CreateChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
