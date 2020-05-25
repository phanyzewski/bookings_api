require 'rails_helper'
RSpec.describe "/bookings", type: :request do
  let(:account) { Account.create! }
  let(:vin) { Faker::Vehicle.vin }
  let(:vehicle) { FactoryBot.create(:vehicle, account_id: account.id) }
  let(:details) { "Customer feels vibration in steering wheel while braking." }
  let(:work_order) { '{"job_id":"1","duration":"2","work":[{"diag":"1","oil change":"0.5","rotation":"0.5"}]}' }
  let(:valid_attributes) {
    {
      account_id: account.id,
      vehicle_id: vehicle.id,
      start_time: Time.current + 1.day,
      duration: 1.hour,
      details: details,
      work_order: work_order,
    }
  }

  let(:invalid_attributes) {
    {
      account_id: '',
      vehicle_id: '',
      start_time: 'tomorrow',
      duration: 'one hour',
      details: 1234,
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Booking.create! valid_attributes
      get bookings_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      booking = Booking.create! valid_attributes
      get booking_url(booking), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Booking" do
        expect {
          post bookings_url,
               params: { booking: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Booking, :count).by(1)
      end

      it "renders a JSON response with the new booking" do
        post bookings_url,
             params: { booking: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/vnd.api+json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Booking" do
        expect {
          post bookings_url,
               params: { booking: invalid_attributes }, as: :json
        }.to change(Booking, :count).by(0)
      end

      it "renders a JSON response with errors for the new booking" do
        post bookings_url,
             params: { booking: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          duration: 2.hours,
          details: "new important details",
          start_time: Time.current + 1.hour,
        }
      }

      it "updates the requested booking" do
        booking = Booking.create! valid_attributes
        patch booking_url(booking),
              params: { booking: new_attributes }, headers: valid_headers, as: :json
        booking.reload
        expect(booking.duration).to eq(2.hours)
        expect(booking.details).to eq("new important details")
      end

      it "renders a JSON response with the booking" do
        booking = Booking.create! valid_attributes
        patch booking_url(booking),
              params: { booking: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the booking" do
        booking = Booking.create! valid_attributes
        patch booking_url(booking),
              params: { booking: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested booking" do
      booking = Booking.create! valid_attributes
      expect {
        delete booking_url(booking), headers: valid_headers, as: :json
      }.to change(Booking, :count).by(-1)
    end
  end
end
