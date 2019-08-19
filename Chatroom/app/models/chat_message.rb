class ChatMessage < ApplicationRecord

  validates :content,presence: true
  after_create_commit { BroadCastMessageJob.perform_later self }
  belongs_to :channel

end
