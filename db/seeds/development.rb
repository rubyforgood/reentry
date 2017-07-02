User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true,
  confirmed_at: '2016-01-02 08:31:23'
)

User.create!(
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false,
  confirmed_at: '2016-01-02 08:31:23'
)


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

domains = YAML.load_file(Rails.root.join('lib', 'seeds', 'domains.yml'))
domains.each do |domain|
  Domain.create(**domain)
  puts "Added domain: #{domain}"
end
puts "There are now #{Domain.count} rows in the domains table"
