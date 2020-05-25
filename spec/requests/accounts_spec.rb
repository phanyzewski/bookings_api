require 'rails_helper'
RSpec.describe "/accounts", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Account. As you add validations to Account, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {}
  }

  let(:email_address) { Faker::Internet.email }
  let(:phone_number) { Faker::PhoneNumber.phone_number }
  let(:last_name) { Faker::Name.last_name }
  let(:first_name) { Faker::Name.first_name }
  let(:vin) { Faker::Vehicle.vin }

  let(:search_params) {
    {
      email_address: email_address,
      phone_number: phone_number,
      last_name: last_name,
      first_name: first_name,
      vin: vin,
    }
  }

  let(:invalid_attributes) {
    {}
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # AccountsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "Get /index" do
    it "renders a successful response" do
      Account.create! valid_attributes
      get accounts_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /search" do
    it "finds the requested resource with valid search params" do
      account = Account.create! valid_attributes
      identity = Identity.create!(account_id: account.id, first_name: first_name, last_name: last_name)

      Vehicle.create!(account_id: account.id, vin: vin, year: 2005)
      EmailAddress.create!(identity_id: identity.id, email: email_address)
      Telephone.create!(identity_id: identity.id, phone_number: phone_number)

      get accounts_search_url(search_params), headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(collection.first.dig('id')).to eq(account.id)
    end

    it "returns an empty colleciton if nothing is found" do
      Account.create! valid_attributes

      get accounts_search_url(search_params), headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(collection.count).to eq(0)
    end

    it "finds the requested resource by email" do
      account = Account.create! valid_attributes
      identity = Identity.create!(account_id: account.id, first_name: first_name, last_name: last_name)
      email_address = EmailAddress.create!(identity_id: identity.id, email: Faker::Internet.email)

      get "/accounts/search?email_address=#{email_address.email}", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(collection.first.dig('id')).to eq(account.id)
    end

    it "finds the requested resource by phone_number" do
      account = Account.create! valid_attributes
      identity = Identity.create!(account_id: account.id, first_name: first_name, last_name: last_name)
      telephone = Telephone.create!(identity_id: identity.id, phone_number: Faker::PhoneNumber.phone_number)

      get "/accounts/search?phone_number=#{telephone.phone_number}", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(collection.first.dig('id')).to eq(account.id)
    end

    it "finds the requested resource by vin" do
      account = Account.create! valid_attributes
      vehicle = Vehicle.create!(account_id: account.id, vin: Faker::Vehicle.vin, year: 2005)

      get "/accounts/search?vin=#{vehicle.vin}", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(collection.first.dig('id')).to eq(account.id)
    end

    it "returns all collections if there are multiple matches" do
      account = Account.create! valid_attributes
      account1 = Account.create! valid_attributes
      Vehicle.create!(account_id: account.id, vin: vin, year: 2005)
      Vehicle.create!(account_id: account1.id, vin: vin, year: 2005)

      get "/accounts/search?vin=#{vin}", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(collection.count).to eq(2)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      account = Account.create! valid_attributes
      get account_url(account), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Account" do
        expect {
          post accounts_url,
               params: { account: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Account, :count).by(1)
      end

      it "renders a JSON response with the new account" do
        post accounts_url,
             params: { account: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/vnd.api+json; charset=utf-8"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested account" do
      account = Account.create! valid_attributes
      expect {
        delete account_url(account), headers: valid_headers, as: :json
      }.to change(Account, :count).by(-1)
    end

    it "destroys associated vehicles" do
      account = Account.create! valid_attributes
      Vehicle.create!(account_id: account.id, vin: vin, year: 2005)
      expect {
        delete account_url(account), headers: valid_headers, as: :json
      }.to change(Vehicle, :count).by(-1)
    end

    it "destroys associated identities" do
      account = Account.create! valid_attributes
      Identity.create!(account_id: account.id, first_name: first_name, last_name: last_name)

      expect {
        delete account_url(account), headers: valid_headers, as: :json
      }.to change(Identity, :count).by(-1)
    end
  end
end
