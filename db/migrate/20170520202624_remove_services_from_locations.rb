class RemoveServicesFromLocations < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :services, :service_description
  end
end
