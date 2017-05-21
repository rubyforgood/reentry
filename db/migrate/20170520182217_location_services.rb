class LocationServices < ActiveRecord::Migration[5.1]
  def change
    create_table :location_services do |t|
      t.integer :location_id
      t.integer :service_id
      t.boolean  :active, null: false, default: true
      t.timestamps
    end

  end
end
