class ChangeLocationServicesStatusField < ActiveRecord::Migration[5.1]
  def up
    remove_column :location_services, :active
    add_column :location_services, :status, :string, null: false, default: 'active'
    add_column :services, :description, :string
  end

  def down
    add_column :location_services, :active, :boolean, null: false, default: true
    remove_column :location_services, :status
    remove_column :services, :description
  end
end
