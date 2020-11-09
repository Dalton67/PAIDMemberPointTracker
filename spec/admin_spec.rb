require 'rails_helper.rb'
require 'spec_helper'
require 'capybara/rspec'
# RSpec.feature "Forms", type: :feature do
#     it 'page has the form to create new' do
#       visit 'members/new'
#       expect(page).to have_selector("form")
#     end
#     it 'page has the form to create new' do
#         visit 'members/new'
#         fill_in 'username', with: "test"
#         fill_in 'password', with: "test"
#         click_on 'Log In'
#     end
# end

RSpec.describe "member crud functionality", type: :system do
  before :each do
    a = AdminUser.new(username: 'testing', password: 'testing')
    a.save()
  end
  it "signs me in and deletes created member" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Members"
    expect(page).to have_content 'Add New Member'
    click_link('Add New Member')
    expect(page).to have_content 'Create Member'
    fill_in('member_first_name', :with => 'Firstname')
    fill_in('member_last_name', :with => 'Last')
    fill_in('member_email', :with => 'test@email.com')
    click_button('Create Member')
    expect(page).to have_content 'Firstname'
    click_link('<< Back to List')
    click_link('Edit')
    fill_in('member_fall_points', :with => '10')
    fill_in('member_spring_points', :with => '20')
    click_button('Update Member')
    click_link('<< Back to List')
    expect(page).to have_content '10'
    expect(page).to have_content '20'
    expect(page).to have_content '30'
    click_link('Delete')
    expect(page).to have_content 'Delete Member'
    click_button('Delete Member')
    expect(page).not_to have_content 'Firstname'
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
    it "routes /members/reset to members#reset" do
    expect(get: "/members/reset").to route_to(
    controller: "members",
    action: "reset",
    )
    end
end

RSpec.feature "Forms", type: :feature do
    it 'page has the form to create new' do
      visit 'members/new'
      expect(page).to have_selector("form")
    end
    it 'new member cannot be created without having admin cridentials' do
        visit 'members/new'
        fill_in 'username', with: "test" 
        fill_in 'password', with: "test" 
        click_on 'Log In'
    end
end

describe "the signin process", type: :feature do
  before :each do
    a = AdminUser.new(username: 'testing', password: 'testing')
    a.save()
  end
  it "signs me in" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Members"
    expect(page).to have_content 'Add New Member'
  end
  it "logging in gives access to documentation" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Documentation"
    expect(page).to have_content 'HOW TO USE:'
  end
  it "signs me in create member" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Members"
    expect(page).to have_content 'Add New Member'
  end

  it "logs out and ends session" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Logout"
    expect(page).to have_content 'Logged out'
  end

  it "loggging out restricts access" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Logout"
    expect(page).to have_content 'Logged out'
    visit '/members'
    expect(page).to have_content 'Please log in'
  end
end
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
    expect(page).to have_content 'Event Ongoing'
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
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "These Emails Do Not Belong To Members"
    first('.actions').click_link('Create New Member')
    fill_in 'member[first_name]', with: 'Test1'
    fill_in 'member[last_name]', with: 'Test 2'
    click_button 'Create Member'
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
    expect(page).to have_content 'Import Points from CSV'
    # click_button 'Choose File'
    attach_file('multipart/form-data', Rails.root + "spec/test.csv")
    click_button 'Import'
    page.driver.browser.switch_to.alert.accept
    # expect(page).to have_content "These Emails Do Not Belong To Members"
    # first('.actions').click_link('Create New Member')
    # fill_in 'member[first_name]', with: 'Test1'
    # fill_in 'member[last_name]', with: 'Test 2'
    # click_button 'Create Member'
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

# RSpec.feature "Forms", type: :feature do
#     it 'page has the form to create new' do
#       visit 'members/new'
#       expect(page).to have_selector("form")
#     end
#     it 'page has the form to create new' do
#         visit 'members/new'
#         fill_in 'username', with: "test"
#         fill_in 'password', with: "test"
#         click_on 'Log In'
#     end
# end

RSpec.describe "member crud functionality", type: :system do
  before :each do
    a = AdminUser.new(username: 'testing', password: 'testing')
    a.save()
  end
  it "signs me in and deletes created member" do
    visit '/access/login'
    fill_in 'username', with: 'testing'
    fill_in 'password', with: 'testing'
    click_on "Log In"
    expect(page).to have_content 'Admin Menu'
    click_on "Manage Members"
    expect(page).to have_content 'Add New Member'
    click_link('Add New Member')
    expect(page).to have_content 'Create Member'
    fill_in('member_first_name', :with => 'Firstname')
    fill_in('member_last_name', :with => 'Last')
    fill_in('member_email', :with => 'test@email.com')
    click_button('Create Member')
    expect(page).to have_content 'Firstname'
    click_link('<< Back to List')
    click_link('Edit')
    fill_in('member_fall_points', :with => '10')
    fill_in('member_spring_points', :with => '20')
    click_button('Update Member')
    click_link('<< Back to List')
    expect(page).to have_content '10'
    expect(page).to have_content '20'
    expect(page).to have_content '30'
    click_link('Delete')
    expect(page).to have_content 'Delete Member'
    click_button('Delete Member')
    expect(page).not_to have_content 'Firstname'
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
    it "routes /members/reset to members#reset" do
    expect(get: "/members/reset").to route_to(
    controller: "members",
    action: "reset",
    )
    end
end
