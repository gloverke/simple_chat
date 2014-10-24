require 'rails_helper'

module SimpleChat
  RSpec.describe Room, :type => :model do
    describe Room, '.user' do
      it 'can be assigned an owner' do
        user = create(:user)
        room = create(:room)
        room.user = user
        room.save!
        expect(room.user_id).to equal user.id
      end
    end
    describe Room, '.users' do
      it 'can be assigned multiple watchers'do
        room = create(:room)
        users = create_list(:user,3)
        room.users = users
        room.save!
        expect(room.users).to eq users
      end
    end

  end
end
