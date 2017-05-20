class RenameServiceIdToTaxonomyId < ActiveRecord::Migration[5.1]
  def change
    rename_column :services, :service_id, :taxonomy_id
  end
end
