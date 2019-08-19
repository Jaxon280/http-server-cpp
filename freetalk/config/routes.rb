Rails.application.routes.draw do
  resources :messages
  resources :channels
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'room#index'
    end
    unauthenticated :user do
      root to: 'devise/registrations#new'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/user/:id' => "room#index"

  get '/user/:id/new' => "room#new"
  post '/user/:id/new' => "room#create"

  get '/user/:id/room/:id' => "channels#index"

  get '/user/:id/room/:id/new' => "channels#new"
  post '/user/:id/room/:id/new' => "channels#create"

  get '/user/:id/room/:id/channel/:id/edit' => "channels#edit"
  post '/user/:id/room/:id/channel/:id/edit' => "channels#update"

  get '/user/:id/room/:id/channel/:id' => "messages#index"

  mount ActionCable.server => '/cable'
end
