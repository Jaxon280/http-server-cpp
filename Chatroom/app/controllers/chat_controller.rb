class ChatController < ApplicationController
  before_action :current_user
  before_action :set_chat_messages

  def index
    @messages = ChatMessage.all
  end





  def set_chat_messages
    @channels = Channel.find(params[:id])
    @users = User.all
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
