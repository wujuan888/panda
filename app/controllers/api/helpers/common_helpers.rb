# frozen_string_literal: true

module Api
  module Helpers
    module CommonHelpers
      extend ActiveSupport::Concern
      include Api::Exception::Common

      included do
        helpers do
          def logger
            Rails.logger
          end

          def success_resp
            {
              status: 0,
              msg: 'success',
              code: '0000'
            }
          end

          def err_resp(err_code, msg)
            {
              status: -1,
              msg: msg,
              code: err_code.to_s
            }
          end

          def current_user
            @current_user ||= ::User.find_by(uuid: params[:uuid])
          end

          def auth_user
            raise AuthUser if current_user.nil?
          end

          def date_today
            Time.now.strftime('%Y%m%d').to_i
          end

          def api_post_request(url, body, headers = { 'Content-Type' => 'application/json' })
            msg = HTTParty.post(url, body: body, headers: headers, timeout: 3).body
            JSON.parse(msg).deep_symbolize_keys
          end

          def api_get_request(url)
            msg = HTTParty.get(url, timeout: 3).body
            JSON.parse(msg).deep_symbolize_keys
          end

        end
      end

      ERR_CODE = {
        POP_UP: 1001
      }.freeze
    end
  end
end
