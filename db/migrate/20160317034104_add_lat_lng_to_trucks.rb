class AddLatLngToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :lat, :string
    add_column :trucks, :lng, :string
  end
end
