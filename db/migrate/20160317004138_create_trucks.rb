class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :trucks do |t|
    	t.string :status
    	t.string :location_description
    	t.string :address
    	t.text :food_items
    	t.string :days_hours
    	t.string :schedule
      t.timestamps null: false
    end
  end
end
