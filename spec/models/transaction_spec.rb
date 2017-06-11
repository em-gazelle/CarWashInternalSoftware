require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:license_plate_number) { Faker::Number.number(7) }

  describe 'transaction validations' do
	let(:invalid_car_missing_attributes) {Fabricate.build(:transaction, vehicle_type: "Car")}
	let(:invalid_truck_missing_attributes) {Fabricate.build(:transaction, license_plate_number: license_plate_number) }
	let(:invalid_truck_bed_attributes) {Fabricate.build(:transaction, vehicle_type: "Truck", license_plate_number: license_plate_number, truck_bed_down: true, truck_bed_muddy: true)}
	let(:invalid_stolen_attributes) {Fabricate.build(:transaction, vehicle_type: "Truck", license_plate_number: "1111111", truck_bed_down: false, truck_bed_muddy: true)}
	let(:invalid_vehicle_type) { Fabricate.build(:transaction, vehicle_type: "Other") }
	let(:invalid_license_plate_length) { Fabricate.build(:transaction, vehicle_type: "Car", license_plate_number: "999999999") }

  	context 'when invalid params' do
  		it 'catches missing attributes errors, dependent on vehicle_type' do
			expect(invalid_car_missing_attributes).to_not be_valid
			expect(invalid_truck_missing_attributes).to_not be_valid
  		end
  		it 'cathes Stolen Vehicle, license_plate_number too long, other vehicle type, and truck bed down errors' do
			expect(invalid_stolen_attributes).to_not be_valid
			expect(invalid_license_plate_length).to_not be_valid
			expect(invalid_vehicle_type).to_not be_valid
			expect(invalid_truck_bed_attributes).to_not be_valid
  		end
  	end
  	context 'when valid params' do
		before do
			@car = Fabricate(:transaction, vehicle_type: "Car", license_plate_number: Faker::Number.number(7))
			@truck = Fabricate(:transaction, vehicle_type: "Truck", license_plate_number: Faker::Number.number(7), truck_bed_down: false, truck_bed_muddy: false)
			@muddy_truck = Fabricate(:transaction, vehicle_type: "Truck", license_plate_number: Faker::Number.number(7), truck_bed_down: false, truck_bed_muddy: true)
		end

		context 'when first time customer' do
	  		it 'calculates and sets price and first_time fields, no discount' do
				expect(@car.price).to eq(5)
				expect(@truck.price).to eq(10)  		
				expect(@muddy_truck.price).to eq(12)  		
	  		end
	  	end
	  	context 'when returning customer' do
	  		it 'calculates and sets price and first_time fields, gives loyalty discount' do
				car = Transaction.create(@car.attributes.delete_if{|a,v| ["price", "id", "returning_customer_discount"].include?(a) })
				truck = Transaction.create(@truck.attributes.delete_if{|a,v| ["price", "id", "returning_customer_discount"].include?(a) })
				muddy_truck = Transaction.create(@muddy_truck.attributes.delete_if{|a,v| ["price", "id", "returning_customer_discount"].include?(a) })

				expect(car.price).to eq(2.5)
				expect(truck.price).to eq(5)  		
				expect(muddy_truck.price).to eq(6)  		
	  		end
	  	end
  	end
  end

end
