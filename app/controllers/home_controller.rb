class HomeController < ApplicationController
	include Geokit::Geocoders

  def index
  	@food_trucks = Truck.all
  end

  def populate_food_trucks
  	# Populate db with trucks if none already exist
  	if Truck.count == 0
	  	results = HTTParty.get 'http://data.sfgov.org/resource/rqzj-sfat.json'
	  	# O(n) blahh
	  	results.each do |food_truck|
	  		# Only want trucks that are active and actually a truck (not a cart)
	  		if food_truck['status'] == "APPROVED" && food_truck['facilitytype'] == "Truck"
	  			truck = Truck.new
	  			truck.status = food_truck['status']
		  		truck.name = food_truck['applicant']
		  		truck.address = food_truck['address']
		  		truck.location_description = food_truck['locationdescription']
		  		truck.food_items = food_truck['fooditems']
		  		truck.days_hours = food_truck['dayshours']
		  		truck.schedule = food_truck['schedule']
		  		# Could geocode this later but why not
		  		coordinates = MultiGeocoder.geocode(truck.address + ', San Francisco, CA')
		  		truck.lat = coordinates.lat
		  		truck.lng = coordinates.lng
		  		truck.save!
		  	else 
		  		next
	  		end
	  	end
	  end
	  render nothing: true
  end


  def show_category_locations
  	category = params[:category]
  	@category_locations = Truck.where("food_items like ?", "%#{category}%")
  	user_location = [session[:lat], session[:lng]]
  	if user_location.present?
  		@nearest_locations = @category_locations.within(5, :origin => user_location)
  	else 
  		@nearest_locations = @category_locations.within(10, :origin => [37.789164, -122.402979])
  	end
  	binding.pry
  end

  def user_location
  	@lat = params[:coordinates][:lat]
  	@lng = params[:coordinates][:lon]
  	session[:lat] = @lat
  	session[:lng] = @lng
  end
end
