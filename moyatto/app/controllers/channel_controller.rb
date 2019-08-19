class ChannelController < ApplicationController

  before_action :set_channel, only: [:show, :update, :channelEdit, :destroy]
  before_action :set_room, only: [:index, :channelAdd, :create, :destroy]
  before_action :current_user

  def index
    @channels_share = @rooms.channels.where(belongs_id: "0")
    @channels_user1 = @rooms.channels.where(belongs_id: "1")
    @channels_user2 = @rooms.channels.where(belongs_id: "2")
  end

  def show
  end

  def channelAdd
  end

  def create
    @channels = @rooms.channels.new(name:params[:name],belongs_id:params[:belongs_id],room_id:params[:id])
    if @channels.save
      redirect_to("/user/#{@current_user.id}/room/#{@rooms.id}") #変数込みのURLにして
    else
      render 'channelAdd'
    end
  end

  def channelEdit
    @channels = Channel.find(params[:id])
    @rooms = Room.includes(:channels).find(@channels.room_id)
    @user_id1 = @rooms.user_id1
    @user_id2 = @rooms.user_id2
  end

  def update
    if @channels.update(channel_params)
      redirect_to("/user/#{@current_user.id}/room/#{@channels.room_id}")
    else
      render 'channelEdit'
    end
  end

  def destroy
    @channels.destroy
  end

  def channel_params
    params.permit(:name, :belongs_id)
  end

  def set_channel
    @channels = Channel.find(params[:id])
  end

  def set_room
    @rooms = Room.includes(:channels).find(params[:id])
    @user_id1 = @rooms.user_id1
    @user_id2 = @rooms.user_id2
  end

  def current_user
    @current_user = User.find(session[:user_id])
  end

end
