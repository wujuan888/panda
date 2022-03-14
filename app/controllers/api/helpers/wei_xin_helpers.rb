# frozen_string_literal: true

module Api
  module Helpers
    module WeiXinHelpers
      extend Grape::API::Helpers

      def app_id
        Yetting.wei_xin['appid']
      end

      def secret
        Yetting.wei_xin['secret']
      end

      def js_code(code)
        url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{app_id}"\
                "&secret=#{secret}&js_code=#{code}&grant_type=authorization_code"
        api_get_request(url)
      end

      def session_key(code)
        js_code(code)[:session_key]
      end

      def decrypt_phone(encrypted_data, iv, session_key)
        pc = Api::Utils::WxBizDataCrypt.new(app_id, session_key)
        decrypted_message = pc.decrypt(encrypted_data, iv)
        logger.info "customer_api::phone decrypted_message #{decrypted_message}"

        decrypted_message['phoneNumber']
      end

    end
  end
end
