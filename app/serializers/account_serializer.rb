class AccountSerializer < BaseSerializer
  include FastJsonapi::ObjectSerializer
  link(:self) { |object| base_url + url_helpers.account_path(object) }

  has_many :identities, lazy_load_data: true, links: {
    rel: ->(object) {
      base_url + url_helpers.account_identities_path(object.id)
    },
  }

  has_many :vehicles, lazy_load_data: true, links: {
    rel: ->(object) {
      base_url + url_helpers.account_vehicles_path(object.id)
    },
  }

  has_many :bookings, lazy_load_data: true, links: {
    rel: ->(object) {
      base_url + url_helpers.account_bookings_path(object.id)
    },
  }

  link(:cmd) { |_object| "#{base_url} #{url_helpers.accounts_search_path}?email_address=,phone_number=,vin=,first_name=,last_name=" }
end
