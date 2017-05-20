class DomainServices < ActiveRecord::Migration[5.1]
  def change
    create_table :domain_services do |t|
      t.string :domain_id
      t.string :service_id
      t.boolean  :active, null: false, default: true
      t.timestamps
    end
  end
end
