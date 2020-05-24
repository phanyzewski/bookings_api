class BookingSerializer < BaseSerializer
  include ActionView::Helpers::DateHelper
  include FastJsonapi::ObjectSerializer

  attributes :start_time, :duration, :details, :work_order

  link(:self) { |object| base_url + url_helpers.booking_path(object) }

  belongs_to :account, links: {
    rel: -> (object){
      base_url + url_helpers.account_path(object.account_id)
    }
  }
  belongs_to :vehicle, links: {
    rel: -> (object){
      base_url + url_helpers.vehicle_path(object.vehicle_id)
    }
  }
end
