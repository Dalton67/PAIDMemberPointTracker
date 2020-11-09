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
RSpec.describe "member crud functionality", type: :system do
  before :each do
    a = AdminUser.new(username: 'testing', password: 'testing')
    a.save()
  end
  it "signs me in and updates created member" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Events"
    expect(page).to have_content 'Add New Event'
    click_link('Add New Event')
    expect(page).to have_content 'Create New Event'
    fill_in('event_title', :with => 'New Event')
    click_button('Create Event')
    expect(page).to have_content 'New Event'
    click_link('Edit')
    fill_in('event_points_worth', :with => '1100')
    click_button('Update Events')
    click_link('<< Back to List')
    expect(page).to have_content '1100'
  end
end
RSpec.describe "API", type: :system do
  before :each do
    a = AdminUser.new(username: 'testing', password: 'testing')
    a.save()
  end
  it "sign in to mamange events" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Events"
    expect(page).to have_content 'Refresh'
    click_link('Refresh')
    expect(page).to have_content 'Future'
  end
  it do 
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Events"
    expect(page).to have_content 'Refresh'
    click_link('Refresh')
    expect(page).to have_content 'Event Ongoing'
    first('.actions').click_link('Show')
  end 
  it do 
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Events"
    expect(page).to have_content 'Refresh'
    click_link('Refresh')
    expect(page).to have_content 'Event Ongoing'
    first('.actions').click_link('Show')
    expect(page).to have_button 'Update Semester'
    click_button('Update Semester')
  end 
  it do 
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Events"
    expect(page).to have_content 'Refresh'
    click_link('Refresh')
    expect(page).to have_content 'Event Ongoing'
    first('.actions').click_link('Show')
    expect(page).to have_button 'Update Semester'
    click_button('Update Semester')
    expect(page).to have_button 'Import Points from Sign Up'
    click_button 'Import Points from Sign Up'
  end 
end
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