class Transaction < ActiveRecord::Base
	validates :vehicle_type, presence: true, inclusion: { in: %w(Car Truck), message: "Sorry, our car wash only services cars and trucks." }
	validates :license_plate_number, presence: true, length: { maximum: 8} , exclusion: { in: %w(1111111), message: "We do not service stolen vehicles." }
	validates :truck_bed_down, acceptance: { accept: false, message: "We do not service trucks with their bed let down." }

	before_save :set_returning_customer_discount, :set_price 


	def set_returning_customer_discount
		# if on an update or edit, make sure to 1, update field if LPN is updated. 2, do NOT update field if LPN is not updated.
		if self.id
			self.returning_customer_discount = !Transaction.where('license_plate_number = ? AND id != ?', self.license_plate_number, self.id).empty?
		else
			self.returning_customer_discount = !Transaction.where(license_plate_number: self.license_plate_number).empty?
		end
		true
	end

	def set_price
		discount = if self.returning_customer_discount then 0.5 else 1 end
		extras = if self.truck_bed_muddy then 2 else 0 end
		base = if (self.vehicle_type == "Car") then 5 else 10 end

		self.price = (base + extras) * discount
	end

end
