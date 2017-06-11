require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:license_plate_number) { Faker::Number.number(7) }
  let(:muddy_truck) { Fabricate(:transaction, vehicle_type: "Truck", license_plate_number: license_plate_number, truck_bed_down: false, truck_bed_muddy: true) }
  let(:valid_truck_attributes) {Fabricate.to_params(:transaction, vehicle_type: "Truck", license_plate_number: license_plate_number, truck_bed_down: false, truck_bed_muddy: false)}
  let(:new_invalid_attributes) { Fabricate.to_params(:transaction, vehicle_type: "Truck", license_plate_number: license_plate_number, truck_bed_down: true) }

  describe "GET #index" do
    it "assigns all transactions as @transactions" do
      transactions = Fabricate.times(3, :transaction, vehicle_type: "Car", license_plate_number: license_plate_number)
      get :index
      expect(assigns(:transactions)).to eq(transactions)
    end
  end

  describe "GET #show" do
    it "assigns the requested transaction as @transaction" do
      get :show, id: muddy_truck.id
      expect(assigns(:transaction)).to eq(muddy_truck)
      expect(response.status).to eq(200)
    end
  end

  describe "GET #new" do
    it "assigns a new transaction as @transaction" do
      get :new
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end
  end

  describe "GET #edit" do
    it "assigns the requested transaction as @transaction" do
      get :edit, id: muddy_truck.id
      expect(assigns(:transaction)).to eq(muddy_truck)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Transaction" do
        expect {
          post :create, transaction: valid_truck_attributes
        }.to change(Transaction, :count).by(1)
      end

      it "assigns a newly created transaction as @transaction and redirects" do
        post :create, transaction: valid_truck_attributes
        expect(assigns(:transaction)).to be_a(Transaction)
        expect(assigns(:transaction)).to be_persisted
        expect(response).to redirect_to(Transaction.last)
      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template and assigns a newly created but unsaved transaction as @transaction" do
        post :create, transaction: new_invalid_attributes
        expect(assigns(:transaction)).to be_a_new(Transaction)
        expect(response).to render_template("new")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested transaction" do
        put :update, id: muddy_truck.id, transaction: valid_truck_attributes
        expect(response).to redirect_to(muddy_truck)
        expect(response.status).to eq(302)
        expect(assigns(:transaction).truck_bed_muddy).to be false
        expect(assigns(:transaction).price).to eq(muddy_truck.price - 2)
      end
    end

    context "with invalid params" do
      it "assigns the transaction as @transaction" do
        put :update, id: muddy_truck.id, transaction: new_invalid_attributes
        expect(assigns(:transaction)).to eq(muddy_truck)
        expect(response).to render_template("edit")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      muddy_truck
    end

    it "destroys the requested transaction" do
      expect {
        delete :destroy, id: muddy_truck.id
      }.to change(Transaction, :count).by(-1)
    end

    it "redirects to the transactions list" do
      delete :destroy, id: muddy_truck.id
      expect(response).to redirect_to(transactions_url)
    end
  end

end
