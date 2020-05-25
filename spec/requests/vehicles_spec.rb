require 'rails_helper'

RSpec.describe "/vehicles", type: :request do
  let(:vin) { Faker::Vehicle.vin }
  let(:make) { Faker::Vehicle.make }
  let(:model) { Faker::Vehicle.model }
  let(:year) { Faker::Vehicle.year }
  let(:color) { Faker::Vehicle.color }

  let(:account) { Account.create! }
  let(:valid_attributes) {
    {
      account_id: account.id,
      vin: vin,
      year: year,
      make: make,
      model: model,
      color: color,
    }
  }

  let(:invalid_attributes) {
    {
      vin: "",
      year: "",
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Vehicle.create! valid_attributes
      get vehicles_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      vehicle = Vehicle.create! valid_attributes
      get vehicle_url(vehicle), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Vehicle" do
        expect {
          post vehicles_url,
               params: { vehicle: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Vehicle, :count).by(1)
      end

      it "renders a JSON response with the new vehicle" do
        post vehicles_url,
             params: { vehicle: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/vnd.api+json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Vehicle" do
        expect {
          post vehicles_url,
               params: { vehicle: invalid_attributes }, as: :json
        }.to change(Vehicle, :count).by(0)
      end

      it "renders a JSON response with errors for the new vehicle" do
        post vehicles_url,
             params: { vehicle: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { vin: "12345678", year: 0 }
      }

      it "updates the requested vehicle" do
        vehicle = Vehicle.create! valid_attributes
        patch vehicle_url(vehicle),
              params: { vehicle: new_attributes }, headers: valid_headers, as: :json
        vehicle.reload
        expect(vehicle.vin).to eq("12345678")
        expect(vehicle.year).to eq(0)
      end

      it "renders a JSON response with the vehicle" do
        vehicle = Vehicle.create! valid_attributes
        patch vehicle_url(vehicle),
              params: { vehicle: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the vehicle" do
        vehicle = Vehicle.create! valid_attributes
        patch vehicle_url(vehicle),
              params: { vehicle: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested vehicle" do
      vehicle = Vehicle.create! valid_attributes
      expect {
        delete vehicle_url(vehicle), headers: valid_headers, as: :json
      }.to change(Vehicle, :count).by(-1)
    end
  end
end
