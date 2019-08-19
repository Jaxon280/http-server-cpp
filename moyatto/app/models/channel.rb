class Channel < ApplicationRecord
  belongs_to :room
  has_many :chat_messages
end
