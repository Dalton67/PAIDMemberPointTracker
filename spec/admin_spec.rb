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
        expect(page).to have_content "PAID Admin"
    end
end