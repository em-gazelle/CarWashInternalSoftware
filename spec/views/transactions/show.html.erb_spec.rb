require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      :license_plate_number => "License Plate Number",
      :vehicle_type => "Vehicle Type",
      :truck_bed_down => false,
      :truck_bed_muddy => false,
      :first_time => false,
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/License Plate Number/)
    expect(rendered).to match(/Vehicle Type/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/9.99/)
  end
end
