class LocationServices < ActiveRecord::Migration[5.1]
  def change
    create_table :location_services do |t|
      t.string :location_id
      t.string :service_id
      t.boolean  :active, null: false, default: true
      t.timestamps
    end

  end
end
