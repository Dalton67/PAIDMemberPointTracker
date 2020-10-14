require 'rails_helper.rb'
require 'spec_helper'
require 'capybara/rspec'
RSpec.feature "Forms", type: :feature do
    it 'page has the form to create new' do
      visit 'members/new'
      expect(page).to have_selector("form")
    end
    it 'page has the form to create new' do
        visit 'members/new'
        fill_in 'username', with: "test" 
        fill_in 'password', with: "test" 
        click_on 'Log In'
    end
end
RSpec.describe "routing to members", type: :routing do
    it "routes /members to members#index" do
      expect(get: "/members").to route_to(
        controller: "members",
        action: "index"
      )
    end
    it "routes /members/1 to members#show" do
    expect(get: "/members/1").to route_to(
    controller: "members",
    action: "show",
    id: "1"
    )
    end
    it "routes /members/new to members#new" do
    expect(get: "/members/new").to route_to(
      controller: "members",
      action: "new"
    )
    end
    it "routes /members/1 to members#destroy" do
    expect(delete: "/members/1").to route_to(
      controller: "members",
      action: "destroy",
      id: "1"
    )
  end
    it "routes /members to members#create" do
    expect(post: "/members").to route_to(
      controller: "members",
      action: "create"
    )
    end
    it "routes /members/1/edit to members#edit" do
        expect(get: "/members/1/edit").to route_to(
        controller: "members",
        action: "edit",
        id: "1"
        )
    end
    it "routes /members/1 to members#update" do
        expect(put: "/members/1").to route_to(
        controller: "members",
        action: "update",
        id: "1"
        )
    end
end