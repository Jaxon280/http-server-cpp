class Message < ApplicationRecord
  validates :content, presence: true #これにより無記入投稿とエンター長押しの連続投稿の2つが同時に防げる
  after_create_commit {MessageBroadcastJob.perform_later self}
end
