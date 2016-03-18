require 'spec_helper'

describe Truck do 
	it "has a valid factory" do 
		FactoryGirl.create(:truck).should be_valid
	end
  it "is invalid without a name" do 
		FactoryGirl.build(:truck, name: nil).should_not be_valid
  end
  it "is invalid without a lat" do 
  	FactoryGirl.build(:truck, lat: nil).should_not be_valid
  end
  it "is invalid without a lng" do 
  	FactoryGirl.build(:truck, lng: nil).should_not be_valid
  end
  it "returns a truck's address as a string" do 
  	truck = FactoryGirl.build(:truck, lat: 37.7721234, lng: -122.4052935)
  	truck.lat_lng.should == "37.7721234, -122.4052935"
  end
  it "returns an array of results that match" do 
    hotdog_truck = FactoryGirl.create(:truck)
    random_truck = FactoryGirl.create(:truck2)
    hamburger_truck = FactoryGirl.create(:truck3)
  	Truck.find_trucks_with_category("Hamburgers").should include(random_truck, hamburger_truck)
  end
end