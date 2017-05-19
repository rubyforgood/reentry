class DomainsAndLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :domains do |t|
      t.string :name
      t.string :kind
      t.text :url
      t.text :description
      t.integer :search_depth
      t.string :status, :default => 'active', :null => false
      t.timestamp :status_date
      t.timestamp :searched_at
      t.timestamps
    end


  end
end
