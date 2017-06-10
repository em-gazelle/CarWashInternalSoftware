json.extract! transaction, :id, :license_plate_number, :vehicle_type, :truck_bed_down, :truck_bed_muddy, :first_time, :price, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
