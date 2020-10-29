require 'rails_helper.rb'
require 'spec_helper'
require 'capybara/rspec'
# RSpec.feature "Forms", type: :feature do
#     it 'page has the form to create new' do
#       visit 'events/new'
#       expect(page).to have_selector("form")
#     end
#     it 'page has the form to create new' do
#         visit 'events/new'
#         fill_in 'event_first_name', with: "Hi" 
#         click_on 'Create events'
#         expect(page).to have_content "Hi"
#     end
# end
RSpec.describe "routing to events", type: :routing do
    it "routes /events to events#index" do
      expect(get: "/events").to route_to(
        controller: "events",
        action: "index"
      )
    end
    it "routes /events/1 to events#show" do
    expect(get: "/events/1").to route_to(
    controller: "events",
    action: "show",
    id: "1"
    )
    end
    it "routes /events/new to events#new" do
    expect(get: "/events/new").to route_to(
      controller: "events",
      action: "new"
    )
    end
    it "routes /events/1 to events#destroy" do
    expect(delete: "/events/1").to route_to(
      controller: "events",
      action: "destroy",
      id: "1"
    )
  end
    it "routes /events to events#create" do
    expect(post: "/events").to route_to(
      controller: "events",
      action: "create"
    )
    end
    it "routes /events/1/edit to events#edit" do
        expect(get: "/events/1/edit").to route_to(
        controller: "events",
        action: "edit",
        id: "1"
        )
    end
    it "routes /events/1 to events#update" do
        expect(put: "/events/1").to route_to(
        controller: "events",
        action: "update",
        id: "1"
        )
    end
end