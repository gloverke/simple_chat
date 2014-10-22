require 'rails_helper'


module SimpleChat
  RSpec.describe UsersController, :type => :controller do
    describe 'POST #change-name' do
      it 'changes the name' do
        user = User.create!
        new_name = 'My New Name'
        post :change_name, {name: new_name, use_route: :users, :format => 'js'}, {id: user.id, name: user.name}
        expect(User.find(user.id).name).to eq new_name
      end
    end
  end
end