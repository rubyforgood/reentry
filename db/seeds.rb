# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

service_text = File.read(Rails.root.join('lib', 'seeds', 'taxonomy.csv'))
csv = CSV.parse(service_text, :headers => true)
csv.each do |row|
  t = Service.new
  t.taxonomy_id = row['taxonomy_id']
  t.name = row['name']
  t.parent_id = row['parent_id']
  t.parent_name = row['parent_name']
  t.save
  puts "#{t.taxonomy_id} #{t.name} saved"
end
puts "There are now #{Service.count} rows in the taxonomies table"
