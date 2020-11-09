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
