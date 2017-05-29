class RenameLocationIdInAddress < ActiveRecord::Migration[5.1]
  def change
  	rename_column :addresses, :loction_id, :location_id
  end
end
