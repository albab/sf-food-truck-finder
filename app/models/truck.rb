class Truck < ActiveRecord::Base
  reverse_geocoded_by :lat, :lng
  after_validation :reverse_geocode
  validates_presence_of :name, :lat, :lng

  def lat_lng 
  	[lat, lng].join ", "
  end

	def self.find_trucks_with_category(category)
	  where("food_items like ?", "%#{category}%")
	end
end
