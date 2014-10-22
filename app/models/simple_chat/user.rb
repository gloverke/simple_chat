module SimpleChat
  class User < ActiveRecord::Base
    belongs_to :room
    has_many :rooms
    def initialize(attributes={})
      attributes ||= {}
      attributes = { name: User.guest_name}.merge attributes
      super
    end

    class << self
      def guest_name
        "Guest-#{(0...6).map { (65 + rand(26)).chr }.join}"
      end

      def load_attributes(id, attrs_to_load)
        attrs_to_load ||= {}
        User.find(id).attributes.select { |param| attrs_to_load.include? param}
      end

    end
  end
end
