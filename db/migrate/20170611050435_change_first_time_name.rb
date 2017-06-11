class ChangeFirstTimeName < ActiveRecord::Migration
  def change
  	rename_column :transactions, :first_time, :returning_customer_discount
  end
end
