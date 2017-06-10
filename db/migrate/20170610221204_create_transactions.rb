class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :license_plate_number
      t.string :vehicle_type
      t.boolean :truck_bed_down
      t.boolean :truck_bed_muddy
      t.boolean :first_time
      t.decimal :price

      t.timestamps null: false
    end
  end
end
