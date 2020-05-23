class IdentitySerializer < BaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :email_addresses, :telephones

  link(:self) { |object| base_url + url_helpers.identity_path(object) }
end
