require 'rails_helper'

RSpec.describe "simple_chat/users/_user_list.html.erb", :type => :view do

  current_user_params = {name: 'John Doe'}

  before (:all) do
    assign(:current_user, build(:user, current_user_params))
    assign(:users, build_list(:user, 3))
  end

  context 'current user' do
    it 'displays the current user' do
      render
      expect(rendered).to have_selector('#current-user', text: current_user_params[:name])
    end
    it 'has a change user name form' do
      render
      expect(rendered).to have_selector 'form #new-name'
    end
  end

  context 'other users' do
    it 'displays a list of users in the room' do
      render
      expect(rendered).to have_css '#user-list'
      expect(rendered).to have_content('uest-', count: 3)
    end
  end


end

