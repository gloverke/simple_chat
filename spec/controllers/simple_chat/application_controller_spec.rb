require 'rails_helper'


module SimpleChat
  RSpec.describe ApplicationController, :type => :controller do

    controller do
      def index
        render text: 'Hello World'
      end
    end

    describe "user validation" do
      it "creates a new user if one not in session or cookie" do
        get :index, nil, {}
        new_user = User.last
        expect(controller.session[:id]).to eq new_user.id
        expect(controller.session[:name]).to eq new_user.name
        expect(response.cookies['user_id']).to eq new_user.id.to_s
      end

      it "pulls user from cookie if exists" do
        user = User.create!
        request.cookies['user_id'] = user.id.to_s
        get :index, nil, {}
        expect(controller.session[:id]).to eq user.id
        expect(controller.session[:name]).to eq user.name
      end

      it "does not change user if it exists " do
        user = User.create!({name: 'test-name'})
        get :index, nil, { id: user.id, name: user.name}
        expect(controller.session[:id]).to eq user.id
        expect(controller.session[:name]).to eq user.name
      end

      it "creates a new user if the cookie id is invalid" do
        request.cookies['user_id'] = 999999
        get :index, nil, {}
        expect(controller.session[:id]).to eq controller.current_user.id
        expect(controller.session[:name]).to eq controller.current_user.name
      end

    end
  end
end