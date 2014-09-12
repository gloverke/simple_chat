feature 'User enters the chat room lobby' do
  scenario 'they see the chat window' do
    visit rooms_path

    expect(page).to have_css '#chat-input'
  end
end