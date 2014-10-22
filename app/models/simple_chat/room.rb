module SimpleChat
  class Room < ActiveRecord::Base
    has_many :users
    belongs_to :user
  end
end
