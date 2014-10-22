require_dependency "simple_chat/application_controller"

module SimpleChat
  class UsersController < ApplicationController

    def change_name
       current_user.update_attribute( :name, params.require(:name))
       respond_to do |format|
         format.js   # just renders messages/create.js.erb
       end
    end
  end
end
