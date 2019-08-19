class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_room

  # GET /channels
  def index
    @channels = @current_room.channels.all
  end

  # GET /channels/1
  def show
  end

  # GET /channels/new
  def new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  def create
    @newchannel = @current_room.build_channel(name: params[:name],belongs_id: params[:belongs_id],room_id: params[:id])

    if @newchannel.save
      redirect_to @newchannel, notice: 'Channel was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /channels/1
  def update
    if @channel.update(channel_params)
      redirect_to @channel, notice: 'Channel was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy
    redirect_to channels_url, notice: 'Channel was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def channel_params
      params.permit(:name, :belongs_id, :room_id)
    end

    def current_user
      @current_user = current_user
    end

    def set_room
      @current_room = Room.includes(:channels).find(params[:id])
    end
end
