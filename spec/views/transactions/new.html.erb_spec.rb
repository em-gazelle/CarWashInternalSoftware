require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      :license_plate_number => "MyString",
      :vehicle_type => "MyString",
      :truck_bed_down => false,
      :truck_bed_muddy => false,
      :first_time => false,
      :price => "9.99"
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input#transaction_license_plate_number[name=?]", "transaction[license_plate_number]"

      assert_select "input#transaction_vehicle_type[name=?]", "transaction[vehicle_type]"

      assert_select "input#transaction_truck_bed_down[name=?]", "transaction[truck_bed_down]"

      assert_select "input#transaction_truck_bed_muddy[name=?]", "transaction[truck_bed_muddy]"

      assert_select "input#transaction_first_time[name=?]", "transaction[first_time]"

      assert_select "input#transaction_price[name=?]", "transaction[price]"
    end
  end
end
