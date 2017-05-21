class DomainServices < ActiveRecord::Migration[5.1]
  def change
    create_table :domain_services do |t|
      t.bigint :domain_id
      t.bigint :service_id
      t.boolean  :active, null: false, default: true
      t.timestamps
    end
  end
end
