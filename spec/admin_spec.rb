require 'rails_helper.rb'
require 'spec_helper'
require 'capybara/rspec'
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
    it "logging in gives access to documentation" do
      visit '/access/login'
      fill_in 'username', with: 'testing'
      fill_in 'password', with: 'testing'
      click_on "Log In"
      expect(page).to have_content 'Admin Menu'
      click_on "Documentation"
      expect(page).to have_content 'HOW TO USE:'
    end
end