require "rails_helper"


module SimpleChat

  feature 'User ' do
    routes = SimpleChat::Engine.routes.url_helpers
    before(:all) do
      load Rails.root + "db/seeds.rb"
    end

    scenario 'assigned a default name' do
      visit routes.rooms_path
      expect(page.body).to have_selector('#current-user', :text =>/[Gg]uest-(.+)/)
    end

    scenario 'can see other users' do
      build_list(:user,3)
      visit routes.rooms_path
      expect(page.body).to have_css '#user-list'
    end

    #need to add mock redis pub sub
    # scenario 'can change the default name', js:true do
    #   visit routes.rooms_path
    #   within("#change-name-form") do
    #     fill_in 'new-name', :with => 'Testname'
    #   end
    #   page.find('#change-name').click
    #   visit routes.rooms_path
    #   expect(page.body).to have_selector('#current-user', :text => 'Testname')
    # end


  end
end
