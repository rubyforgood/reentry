class AddDomainToLocations < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :domain, foreign_key: true
  end
end
