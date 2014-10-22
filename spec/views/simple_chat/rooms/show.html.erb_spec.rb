require 'rails_helper'

module SimpleChat
  RSpec.describe "simple_chat/rooms/show.html.erb", :type => :view do
    # routes { SimpleChat::Engine.routes }

    # routes { SimpleChat::Engine.routes }
    current_user_params = {name: 'John Doe'}

    before(:all) do
      assign(:current_user, current_user_params)
      assign(:users, build_list(:user, 3))
      assign(:room, build(:room))
    end


    context 'partials' do

      it ('renders user list') do
        render
        expect(response).to render_template(:partial => 'simple_chat/users/_user_list')
      end
    end

  end
end