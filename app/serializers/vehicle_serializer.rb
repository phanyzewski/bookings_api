class VehicleSerializer < BaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :vin, :year, :make, :model, :color

  link(:self) { |object| base_url + url_helpers.vehicle_path(object) }
end
