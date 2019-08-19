Rails.application.routes.draw do
  root 'chat_rooms#show'
  mount ActionCable.server => '/cable'
end
