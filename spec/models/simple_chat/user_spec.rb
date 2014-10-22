require 'rails_helper'

module SimpleChat
  RSpec.describe User, :type => :model do
    describe User, '#name' do
      it 'has a default name of Guest<random>' do
        user = User.create!
        expect(user.name).to match /[Gg]uest(.+)/
      end

      it 'does not overwrite a given name' do
        user = User.create!(name: 'MyName')
        expect(user.name).to eq 'MyName'
      end

      it 'allows changing the name' do
        user = User.create!
        user.update_attribute(:name, 'MyName')
        user.save!
        expect(user.name).to eq 'MyName'
      end
    end

    describe User, '.room' do
      it 'can be assigned a room' do
        user = User.create!
        room = Room.create!
        user.room = room
        user.save!
        expect(user.room_id).to equal room.id
      end
    end

    describe User, '.load_attributes' do
      it 'is passed a hash of attributes to load' do
        user = User.create!(name: 'My Name')
        loaded_attrs = User.load_attributes(user.id,%w[id name])
        expect(loaded_attrs).to eq({'id'=> user.id,'name' => user.name })
      end
    end

  end


end
