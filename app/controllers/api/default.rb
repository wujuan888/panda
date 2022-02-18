# frozen_string_literal: true

# require 'api/exception/common'

module Api
  module Default
    extend ActiveSupport::Concern

    included do
      include Helpers::CommonHelpers
      include Helpers::UtilsHelpers

      version 'v1', using: :path

      content_type :json, 'application/json'

      default_format :json

      rescue_from Api::Exception::Common::AuthUser do |e|
        logger.error "Api::Exception::Common::AuthUser catch error #{e.message}"
        error!({ code: 1001, error: e }, 401)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        logger.error "Grape::Exceptions::ValidationErrors catch error #{e.message}"
        error!({ code: 1002, error: e.message }, 400)
      end

      rescue_from NoMethodError do |e|
        logger.error "NoMethodError catch error #{e.message}"
        error!({ code: 1003, error: e.message }, 422)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        logger.error "ActiveRecord::RecordNotFound catch error #{e.message}"
        error!({ code: 1004, error: e.message }, 404)
      end

      rescue_from ArgumentError do |e|
        logger.error "ArgumentError catch error #{e.message}"
        error!({ code: 1005, error: e }, 405)
      end

      rescue_from :all do |e|
        logger.error "Rescue_from all catch error #{e.message}"
        error!({ code: 1000, error: e.message }, 500)
      end
    end
  end
end
