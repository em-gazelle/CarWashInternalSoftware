require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        :license_plate_number => "License Plate Number",
        :vehicle_type => "Vehicle Type",
        :truck_bed_down => false,
        :truck_bed_muddy => false,
        :first_time => false,
        :price => "9.99"
      ),
      Transaction.create!(
        :license_plate_number => "License Plate Number",
        :vehicle_type => "Vehicle Type",
        :truck_bed_down => false,
        :truck_bed_muddy => false,
        :first_time => false,
        :price => "9.99"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", :text => "License Plate Number".to_s, :count => 2
    assert_select "tr>td", :text => "Vehicle Type".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
