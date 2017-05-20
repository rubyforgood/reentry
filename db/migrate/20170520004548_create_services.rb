class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name
      t.string :service_id
      t.string :parent_id
      t.string :parent_name

      t.timestamps
    end
  end
end
