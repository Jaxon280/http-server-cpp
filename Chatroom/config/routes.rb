Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/user/register' => "user#register"
  post '/user/register' => "user#create"

  get '/user/:id/profile' => "user#profile"
  post '/user/:id/profile' => "user#update"

  get '/user/:id' => "room#index"

  get '/user/:id/roomadd' => "room#roomAdd"
  post '/user/:id/roomadd' => "room#create"

  get '/user/:id/room/:id' => "channel#index"

  get '/user/:id/room/:id/channeladd' => "channel#channelAdd"
  post '/user/:id/room/:id/channeladd' => "channel#create"

  get '/user/:id/room/:id/channel/:id/edit' => "channel#channelEdit"
  post '/user/:id/room/:id/channel/:id/edit' => "channel#update"

  get '/user/:id/room/:id/channel/:id' => "chat#index"

  mount ActionCable.server => '/cable'
end
