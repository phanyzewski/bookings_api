require 'rails_helper'
RSpec.describe "/identities", type: :request do
  let(:valid_attributes) {
    {
      account_id: account.id,
      first_name: first_name,
      last_name: last_name,
    }
  }

  let(:account) { Account.create! }
  let(:last_name) { Faker::Name.last_name }
  let(:first_name) { Faker::Name.first_name }
  let(:email) { Faker::Internet.email }

  let(:invalid_attributes) {
    {
      account_id: 1,
      first_name: '',
      last_name: '',
     }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Identity.create! valid_attributes
      get identities_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      identity = Identity.create! valid_attributes
      get identity_url(identity), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Identity" do
        expect {
          post identities_url,
               params: { identity: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Identity, :count).by(1)
      end

      it "renders a JSON response with the new identity" do
        post identities_url,
             params: { identity: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/vnd.api+json; charset=utf-8"))
      end
    end

    context "with valid email parameters" do
      let(:email_attributes) {
        { email_address: { email: email, preferred: true } }
      }
      it "creates a new identity with an email" do
        post identities_url,
             params: { identity: valid_attributes.merge(email_attributes) }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/vnd.api+json; charset=utf-8"))

      end
    end

    context "with invalid parameters" do
      it "does not create a new Identity" do
        expect {
          post identities_url,
               params: { identity: invalid_attributes }, as: :json
        }.to change(Identity, :count).by(0)
      end

      it "renders a JSON response with errors for the new identity" do
        post identities_url,
             params: { identity: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          first_name: "new", last_name: "name"
        }
      }

      it "updates the requested identity" do
        identity = Identity.create! valid_attributes
        patch identity_url(identity),
              params: { identity: new_attributes }, headers: valid_headers, as: :json
        identity.reload
        expect(identity.first_name).to eq('new')
        expect(identity.last_name).to eq('name')
      end

      it "renders a JSON response with the identity" do
        identity = Identity.create! valid_attributes
        patch identity_url(identity),
              params: { identity: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the identity" do
        identity = Identity.create! valid_attributes
        patch identity_url(identity),
              params: { identity: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/vnd.api+json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested identity" do
      identity = Identity.create! valid_attributes
      expect {
        delete identity_url(identity), headers: valid_headers, as: :json
      }.to change(Identity, :count).by(-1)
    end
  end
end
