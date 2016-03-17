class AddNameToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :name, :string
  end
end
