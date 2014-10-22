require "rails_helper"

module SimpleChat
  RSpec.describe RoomsController, :type => :routing do
    describe "routing" do
       routes { SimpleChat::Engine.routes }

      it "routes to #index" do
        expect(:get => "/rooms").to route_to("simple_chat/rooms#index")
      end

      # it "routes to #new" do
      #   expect(:get => "/rooms/new").to route_to("simple_chat/rooms#new")
      # end

      it "routes to #show" do
        expect(:get => "/rooms/1").to route_to("simple_chat/rooms#show", :id => "1")
      end
      #
      # it "routes to #edit" do
      #   expect(:get => "/rooms/1/edit").to route_to("simple_chat/rooms#edit", :id => "1")
      # end
      #
      # it "routes to #create" do
      #   expect(:post => "/rooms").to route_to("simple_chat/rooms#create")
      # end
      #
      # it "routes to #update" do
      #   expect(:put => "/rooms/1").to route_to("simple_chat/rooms#update", :id => "1")
      # end
      #
      # it "routes to #destroy" do
      #   expect(:delete => "/rooms/1").to route_to("simple_chat/rooms#destroy", :id => "1")
      # end

    end
  end
end
