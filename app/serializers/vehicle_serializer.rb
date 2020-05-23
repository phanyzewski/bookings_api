class VehicleSerializer < BaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :vin, :year

  link(:self) { |object| base_url + url_helpers.vehicle_path(object) }
end
