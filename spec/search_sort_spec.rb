require 'rails_helper.rb'
require 'spec_helper'
require 'capybara/rspec'

RSpec.describe 'Search', type: :system  do
    describe "the signin process", type: :feature do
        before :each do
          a = AdminUser.new(username: 'testing', password: 'testing')
          a.save()
        end

        it "signs me in and creates member" do
            visit '/access/login'
            fill_in 'username', with: 'testing'
            fill_in 'password', with: 'testing'
            click_on "Log In"
            expect(page).to have_content 'Admin Menu'
            click_on "Manage Members"

            expect(page).to have_content 'Add New Member'
            click_link('Add New Member')
            expect(page).to have_content 'Create Member'
            fill_in('member_first_name', :with => 'John')
            fill_in('member_last_name', :with => 'Lovage')
            fill_in('member_email', :with => 'john_lovage@email.com')
            fill_in('member_fall_points', :with => 12)
            fill_in('member_spring_points', :with => 34)
            fill_in('member_total_points', :with => 46)
            click_button('Create Member')
            expect(page).to have_content 'First'

            expect(page).to have_content 'Add New Member'
            click_link('Add New Member')
            expect(page).to have_content 'Create Member'
            fill_in('member_first_name', :with => 'Zain')
            fill_in('member_last_name', :with => 'McDonald')
            fill_in('member_email', :with => 'zmdS@email.com')
            fill_in('member_fall_points', :with => 145)
            fill_in('member_spring_points', :with => 4)
            fill_in('member_total_points', :with => 1235)
            click_button('Create Member')
            expect(page).to have_content 'First'

            expect(page).to have_content 'Add New Member'
            click_link('Add New Member')
            expect(page).to have_content 'Create Member'
            fill_in('member_first_name', :with => 'Slime')
            fill_in('member_last_name', :with => 'Machine')
            fill_in('member_email', :with => 'slime@email.com')
            fill_in('member_fall_points', :with => 1)
            fill_in('member_spring_points', :with => 2)
            fill_in('member_total_points', :with => 5)
            click_button('Create Member')
            expect(page).to have_content 'First'


            # try search functionality
            fill_in('search', :with => 'Slime')
            click_button('Search')
            expect(page).to have_content 'Slime'
            expect(page).not_to  have_content 'Zain'
            click_link('Reset')

            # try sort functionality
            select 'Total Points', from: 'sort'
            select 'Fall Points', from: 'sort'
            select 'Spring Points', from: 'sort'
            select 'First Name', from: 'sort'
            select 'Last Name', from: 'sort'

          end
    end
end