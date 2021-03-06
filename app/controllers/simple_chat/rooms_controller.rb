require_dependency "simple_chat/application_controller"

module SimpleChat
  class RoomsController < ApplicationController
    before_action :set_room, only: [:rooms, :edit, :update, :destroy]
    # GET /rooms
    def index
      redirect_to room_path(1)
    end


    # GET /rooms/1
    def show
      gon.room_id = params[:id]
      gon.events_path = streaming_events_path(gon.room_id)
      gon.chat_url = messages_send_message_path
      current_user.update_attribute(:room_id, gon.room_id)
      @room = Room.find(gon.room_id)
      @users = User.where(room_id: gon.room_id)
      $redis.publish("messages_#{current_user.room_id.to_s }.user_entered", @current_user.to_json)
    end
    #
    # # GET /rooms/new
    # def new
    #   @room = Room.new
    # end
    #
    # # GET /rooms/1/edit
    # def edit
    # end
    #
    # # POST /rooms
    # def create
    #   @room = Room.new(room_params)
    #
    #   if @room.save
    #     redirect_to @room, notice: 'Room was successfully created.'
    #   else
    #     render :new
    #   end
    # end
    #
    # # PATCH/PUT /rooms/1
    # def update
    #   if @room.update(room_params)
    #     redirect_to @room, notice: 'Room was successfully updated.'
    #   else
    #     render :edit
    #   end
    # end
    #
    # # DELETE /rooms/1
    # def destroy
    #   @room.destroy
    #   redirect_to rooms_url, notice: 'Room was successfully destroyed.'
    # end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_room

      unless params[:id] == '0'
        @room = Room.find(params[:id])
      else
        @room = Room.new(id: 0, name: "Lobby")
      end
    end

    # Only allow a trusted parameter "white list" through.
    def room_params
      params.require(:room).permit(:name, :user_id, :is_public)
    end
  end
end
