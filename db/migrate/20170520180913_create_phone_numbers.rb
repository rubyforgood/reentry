class CreatePhoneNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.string :kind
      t.string :description
      t.integer :location_id

      t.timestamps
    end
  end
end
