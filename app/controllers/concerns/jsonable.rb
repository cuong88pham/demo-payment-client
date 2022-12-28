module Jsonable
  extend ActiveSupport::Concern

  included do
    before_action :set_json_as_default_format

    def set_json_as_default_format
      request.format = :json
    end
  end
end
