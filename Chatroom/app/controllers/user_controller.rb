class UserController < ApplicationController
  before_action :set_channel, only: [:show, :update, :profile, :destroy]

  def index
  end

  def show
  end

  def register
    @users = User.new
  end

  def create
    @users = User.new(user_params)
    if @users.save
      if params[:image]
        File.binwrite("public/user_images/#{@users.id}.jpg", params[:image].read)
        @users.update(image: "#{@users.id}.jpg" )
      else
        @users.update(image: "default.jpg" )
      end
      session[:user_id] = @users.id
      redirect_to("/user/#{@users.id}/roomadd") #変数込みのURLにして
    else
      render 'new'
    end
  end

  def profile
  end

  def update
    if @users.update(user_params)
      if params[:image]
        File.binwrite("public/user_images/#{@users.id}.jpg", params[:image].read)
        @post.update(image: "#{@users.id}.jpg" )
      end

      redirect_to("/channel/:id/list")
    else
      render 'edit'
    end
  end

  def destroy
    @users.destroy
    redirect_to
  end

  def user_params
    params.permit(:name, :image)
  end

  def set_channel
    @users = User.find(params[:id])
  end

end
