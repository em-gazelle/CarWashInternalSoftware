# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


25.times do
	Transaction.create(license_plate_number: Faker::Number.number(7), vehicle_type: "Truck", truck_bed_down: (rand < 0.9), truck_bed_muddy: (rand < 0.6))
end

25.times do
	Transaction.create(license_plate_number: Faker::Number.number(7), vehicle_type: "Car")
end