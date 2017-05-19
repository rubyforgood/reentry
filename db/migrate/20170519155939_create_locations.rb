class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :county
      t.string :name
      t.string :address
      t.string :phone
      t.string :website
      t.string :services
      t.string :type_of_services

      t.timestamps
    end
  end
end
