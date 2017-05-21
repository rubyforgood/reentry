class ChangeLocationServicesStatusField < ActiveRecord::Migration[5.1]
  def change
    remove_column :location_services, :active
    add_column :location_services, :status, :string, null: false, default: 'active'
  end
end
