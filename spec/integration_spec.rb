require "capybara/rspec"
require "./app"
require "pry"
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# describe 'the project creation path', {:type => :feature} do
#   it 'takes the user to the homepage where they can add a recipe' do
#     visit '/'
#     fill_in('Recipe Title', :with => 'Pumpkin Soup')
#     click_button('Add Recipe')
#     expect(page).to have_content('Pumpkin Soup')
#   end
# end
