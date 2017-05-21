class RecreateServicesJoinTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :domain_services
    drop_table :location_services

    create_table :domain_services do |t|
      t.references :domain, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.boolean  :active, null: false, default: true
      t.timestamps
    end

    create_table :location_services do |t|
      t.references :location, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.boolean  :active, null: false, default: true
      t.timestamps
    end
  end
end
