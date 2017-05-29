class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :loction_id
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state_province
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
