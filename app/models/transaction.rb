class Transaction < ActiveRecord::Base
	validates :vehicle_type, presence: true, inclusion: { in: %w(Car Truck), message: "Sorry, our car wash only services cars and trucks." }
	validates :license_plate_number, presence: true, length: { maximum: 8} , exclusion: { in: %w(1111111), message: "We do not service stolen vehicles." }
	validates :truck_bed_down, acceptance: { accept: false, message: "We do not service trucks with their bed let down." }

	# before_create :set_price

	# def set_price
	# 	discount = if first_time then .5 else 1 end
	# 	extras = if self.truck_bed_muddy then 2 else 0 end
	# 	base = if (self.vehicle_type == "car") then 5 else 10 end

	# 	self.price = (base + extras) * discount
	# end

	# def first_time
	# 	self.first_time = Transaction.exists?(self.license_plate_number)
	# end

end
