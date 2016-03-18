require 'spec_helper'
require 'capybara/rspec'

describe 'Trucks' do 

	before(:all) do 
		truck = FactoryGirl.create(:truck)
		truck2 = FactoryGirl.create(:truck2)
	end

	it "should respond to a location search for bagels" do
	  get '/show_category_locations/bagels'
	  response.header['Content-Type'].should include 'application/json'
	  expect(response).to be_success
	end

	it "should set user_location" do 
		get '/user_location', { coordinates: { lat: 27.380841, lng: 33.631839 }, format: 'js' }
		session[:lat].should == "27.380841"
	end

	it "should be able to click location in list to center map / pull json", js: true do
	  visit '/'
	  expect(page).to have_css('div#map')  
	  click_link 'Bagels'
	  sleep(2)
	end
end