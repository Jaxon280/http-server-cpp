class RoomController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user
  before_action :set_room, only: [:show, :update, :edit, :destroy]

  def index
    @rooms = current_user.rooms.all
  end

  def show
  end

  def new
  end

  def create
    @newroom = current_user.rooms.build(friend_id: params[:user_id])
    User.find(params[:user_id]).build_room(friend_id: current_user.id)
    if @newroom.save
      redirect_to("/user/#{current_user.id}/room/#{@newroom.id}") #変数込みのURLにして
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @rooms.destroy
  end

  private

    def channel_params
      params.permit(:friend_id)
    end

    


end
