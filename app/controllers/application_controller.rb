class ApplicationController < ActionController::API
  include JSONAPI::Errors
  include JSONAPI::Pagination

  def jsonapi_meta(resources)
    pagination = jsonapi_pagination_meta(resources)

    { pagination: pagination, total: resources.size } if pagination.present?
  end
end
