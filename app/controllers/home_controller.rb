class HomeController < ApplicationController
	include Geokit::Geocoders
  protect_from_forgery except: :user_location # For testing

  def index
  	@food_trucks = Truck.all
  end

  def populate_food_trucks
  	# Populate db with trucks if none already exist
  	if Truck.count == 0
      # DataSF:FoodTrucks 
	  	results = HTTParty.get 'http://data.sfgov.org/resource/rqzj-sfat.json'
	  	# lazy loading blah
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
		  		truck.lat = coordinates.lat.to_f
		  		truck.lng = coordinates.lng.to_f
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
    # Find trucks that carry items of the selected category
  	@category_locations = Truck.where("food_items like ?", "%#{category}%")
  	user_location = [session[:lat], session[:lng]]
  	if user_location.present?
  		@nearest_locations = @category_locations.near(user_location, 20).as_json
      # If we are in Phoenix or something, just set location to SF and center
  		if @nearest_locations.empty?
  			@nearest_locations = @category_locations.near('San Francisco, CA', 20).as_json
  			@center_sf = true
  		end
  	else 
  		@nearest_locations = @category_locations.near('San Francisco, CA', 20).as_json
  	end
    render json: @nearest_locations
  end

  def user_location
    # Grabbing coords to set and center 
  	@lat = params[:coordinates][:lat]
  	@lng = params[:coordinates][:lon]
    # Save for later
  	session[:lat] = @lat
  	session[:lng] = @lng
  end
end
