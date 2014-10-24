require_dependency "simple_chat/application_controller"

module SimpleChat
  class UsersController < ApplicationController

    def change_name
       current_user.update_attribute( :name, params.require(:name))
       respond_to do |format|
         format.js   # just renders messages/create.js.erb
       end
       $redis.publish("#{"messages_" + current_user.room_id.to_s }.user_rename",{id: current_user.id, name: current_user.name}.to_json)
    end
  end
end
