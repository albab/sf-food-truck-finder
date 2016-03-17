class LatLngFixForPg < ActiveRecord::Migration
 def change
  remove_column :trucks, :lat
  add_column :trucks, :lat, :float
  remove_column :trucks, :lng
  add_column :trucks, :lng, :float
 end
end
