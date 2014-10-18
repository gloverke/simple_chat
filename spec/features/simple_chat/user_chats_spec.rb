require "rails_helper"
require "mocks/mock_pub_sub"

module SimpleChat
   describe "user chats" do
      routes = SimpleChat::Engine.routes.url_helpers
    before(:all) do

  # Redis.stub(:new).and_return { redis_instance }
  # Redis::Store.stub(:new).and_return { redis_instance }
    end
#     
    # it  'sees the chat window' do
      # add_mock_redis()
      # visit routes.rooms_path      
      # expect(page).to have_css '#chat-input'
      # expect(page).to have_css '#chat-output'
    # end
#     
#     it 'sends a message and sees the chat', :js => true do
#       add_mock_redis()
#       visit routes.rooms_path
#       within('#input-panel') do
#         fill_in 'chat', :with => 'Hello'
#       end
#
#       print page.html
#       click_button 'send'
#       # (find('#sidebar').find('h1')).to have_content('Something')
#       # print page.html
#       expect(find("#chat-output")).to have_content('Hello')
#     end
    
    #cannot test any server side ven
    
   def add_mock_redis()
      redis_instance = MockPubSub.new
      allow(Hash).to receive(:to_json) { puts " RAHSThe RSpec Book" }
      mock_redis = object_double("Redis")
      allow(mock_redis).to receive(:new).and_return(redis_instance)
    end

  end
  
end