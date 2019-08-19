class RoomController < ApplicationController

  before_action :set_room, only: [:show, :update, :edit, :destroy]
  before_action :current_user

  def index
    @rooms1 = Room.where(user_id1: @current_user.id)
    @rooms2 = Room.where(user_id2: @current_user.id)
  end

  def show
  end

  def roomAdd
    @rooms = Room.new
  end

  def create

    @rooms = Room.create(user_id1: @current_user.id, user_id2: params[:user_id])
    if @rooms.save
      redirect_to("/user/#{@current_user.id}/room/#{@rooms.id}") #変数込みのURLにして
    else
      render 'roomAdd'
    end
  end

  def edit
  end

  def destroy
    @rooms.destroy
    redirect_to
  end

  def channel_params
    params.permit(:user_id1,:user_id2)
  end

  def set_room
    @rooms = Room.find(params[:id])
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

end
