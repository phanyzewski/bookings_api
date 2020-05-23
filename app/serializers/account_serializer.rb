class AccountSerializer < BaseSerializer
  include FastJsonapi::ObjectSerializer
  link(:self) { |object| url_helpers.account_path(object) }

  has_many :identities, links: {
    rel: -> (object){
      base_url + url_helpers.account_identities_path(object.id)
    }
  }

  has_many :vehicles, links: {
    rel: -> (object){
      base_url + url_helpers.account_vehicles_path(object.id)
    }
  }

  has_many :bookings, links: {
    rel: -> (object){
      base_url + url_helpers.account_bookings_path(object.id)
    }
  }
end
