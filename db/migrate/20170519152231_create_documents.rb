class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.references :link
      t.string :content

      t.timestamp :extracted_at
      t.timestamps
    end
  end
end
