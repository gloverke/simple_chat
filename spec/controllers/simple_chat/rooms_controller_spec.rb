require 'rails_helper'
require 'mock_redis_pub_sub'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

module SimpleChat
  RSpec.describe RoomsController, :type => :controller do

    # This should return the minimal set of attributes required to create a valid
    # Room. As you add validations to Room, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      {id:2, name: "My New Room"}
    }

    let(:invalid_attributes) {
       {invalid: "invalid"}
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # RoomsController. Be sure to keep this updated too.
    let(:guest_session) { {} }
    let(:user_session) { {user_id: 1} }

    before(:all) do
      load Rails.root + "db/seeds.rb"
    end
    describe "GET index" do
      it "redirects the index to the lobby room(1)" do
        get :index, {use_route: :rooms}, guest_session
        expect(response).to redirect_to room_path(1)
      end
    end

    describe "GET show" do
      it "assigns users in room to @users variable" do
        users = create_list(:user,2, room_id:1)
        get :show, {:id => 1, use_route: :rooms}, { id: users[0].id, name: users[0].name }
        expect(assigns(:users)).to match_array users
      end

      it "assigns @room variable to current room" do
        room = create(:room,valid_attributes)
        get :show, {:id => room.to_param, use_route: :rooms}, { user: build(:user)}
        expect(assigns(:room)).to eq(room)
      end

      it "changes current user (session[:user]) to new room" do
        room = create(:room, valid_attributes)
        user = create(:user, name: 'Roomed User')
        get :show, {:id => room.to_param, use_route: :rooms}, { user: user}
        expect(controller.current_user.room_id).to eq room.id
      end

      it "assigned current user to @current_user" do
        user =  create(:user, name: 'Roomed User')
        get :show, {:id => 1, use_route: :rooms}, { id: user.id, name: user.name}
        expect(assigns(:current_user)).to eq(user)
      end


      it "notifies others users of a user entering" do
        user = create(:user)
        pubsub = MockRedisPubSub.new
        get :show, {:id => 1, use_route: :rooms}, { id: user.id, name: user.name}
        expect(pubsub.published? "messages_1.user_entered", user.to_json)
      end

    end

    # describe "GET new" do
    #   it "assigns a new room as @room" do
    #     get :new, {use_route: :rooms}, valid_session
    #     expect(assigns(:room)).to be_a_new(Room)
    #   end
    # end
    #
    # describe "GET edit" do
    #   it "assigns the requested room as @room" do
    #     room = Room.create! valid_attributes
    #     get :edit, {:id => room.to_param,use_route: :rooms}, valid_session
    #     expect(assigns(:room)).to eq(room)
    #   end
    # end
    #
    # describe "POST create" do
    #   describe "with valid params" do
    #     it "creates a new Room" do
    #       expect {
    #         post :create, {:room => valid_attributes, use_route: :rooms}, valid_session
    #       }.to change(Room, :count).by(1)
    #     end
    #
    #     it "assigns a newly created room as @room" do
    #       post :create, {:room => valid_attributes,use_route: :rooms}, valid_session
    #       expect(assigns(:room)).to be_a(Room)
    #       expect(assigns(:room)).to be_persisted
    #     end
    #
    #     it "redirects to the created room" do
    #       post :create, {:room => valid_attributes,use_route: :rooms}, valid_session
    #       expect(response).to redirect_to(Room.last)
    #     end
    #   end
    #
    #   describe "with invalid params" do
    #     it "assigns a newly created but unsaved room as @room" do
    #       post :create, {:room => invalid_attributes,use_route: :rooms}, valid_session
    #       expect(assigns(:room)).to be_a_new(Room)
    #     end
    #
    #     it "re-renders the 'new' template" do
    #       post :create, {:room => invalid_attributes,use_route: :rooms}, valid_session
    #       expect(response).to render_template("new")
    #     end
    #   end
    # end
    #
    # describe "PUT update" do
    #   describe "with valid params" do
    #     let(:new_attributes) {
    #       skip("Add a hash of attributes valid for your model")
    #     }
    #
    #     it "updates the requested room" do
    #       room = Room.create! valid_attributes
    #       put :update, {:id => room.to_param, :room => new_attributes,use_route: :rooms}, valid_session
    #       room.reload
    #       skip("Add assertions for updated state")
    #     end
    #
    #     it "assigns the requested room as @room" do
    #       room = Room.create! valid_attributes
    #       put :update, {:id => room.to_param, :room => valid_attributes,use_route: :rooms}, valid_session
    #       expect(assigns(:room)).to eq(room)
    #     end
    #
    #     it "redirects to the room" do
    #       room = Room.create! valid_attributes
    #       put :update, {:id => room.to_param, :room => valid_attributes,use_route: :rooms}, valid_session
    #       expect(response).to redirect_to(room)
    #     end
    #   end
    #
    #   describe "with invalid params" do
    #     it "assigns the room as @room" do
    #       room = Room.create! valid_attributes
    #       put :update, {:id => room.to_param, :room => invalid_attributes,use_route: :rooms}, valid_session
    #       expect(assigns(:room)).to eq(room)
    #     end
    #
    #     it "re-renders the 'edit' template" do
    #       room = Room.create! valid_attributes
    #       put :update, {:id => room.to_param, :room => invalid_attributes,use_route: :rooms}, valid_session
    #       expect(response).to render_template("edit")
    #     end
    #   end
    # end
    #
    # describe "DELETE destroy" do
    #   it "destroys the requested room" do
    #     room = Room.create! valid_attributes
    #     expect {
    #       delete :destroy, {:id => room.to_param,use_route: :rooms}, valid_session
    #     }.to change(Room, :count).by(-1)
    #   end
    #
    #   it "redirects to the rooms list" do
    #     room = Room.create! valid_attributes
    #     delete :destroy, {:id => room.to_param,use_route: :rooms}, valid_session
    #     expect(response).to redirect_to(rooms_url)
    #   end
    # end

  end
end
