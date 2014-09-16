require "rails_helper"

module SimpleChat
   describe "user chats" do
      routes = SimpleChat::Engine.routes.url_helpers
    
    it  'sees the chat window' do
      visit routes.rooms_path      
      expect(page).to have_css '#chat-input'
      expect(page).to have_css '#chat-output'
    end
    
    it 'sends a message and sees the chat' do
      visit routes.rooms_path
      within('#input-panel') do
        fill_in 'chat', :with => 'Hello'        
      end
      click_button 'send'
      # (find('#sidebar').find('h1')).to have_content('Something')
      expect(find("#chat-output")).to have_content('Hello')
    end
    
  end
end