class BaseSerializer
  class << self
    delegate :url_helpers, to: :'Rails.application.routes'

    def base_url
      Rails.application.credentials[:base_url] || "htttp://example.com"
    end
  end
end
