require 'rails_helper'
FactoryGirl.define do
  factory :user, class: SimpleChat::User do
    name { SimpleChat::User.guest_name }
  end
end