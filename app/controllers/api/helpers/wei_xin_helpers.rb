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

      def js_token
        url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&"\
              "appid=#{app_id}&#{secret}"
        api_get_request(url)
      end

      def create_wxacode(params)
        token_hash = js_token
        if token_hash['access_token']
          url = "https://api.weixin.qq.com/wxa/getwxacode?access_token=#{token_hash['access_token']}"
          result = api_post_request(url, params)
          logger.info(" create_wxacode   result ", result)
          file_name = shared_path + 'qqqqqq.jpeg'
          File.open(file_name) do |f|
            f.write [img.gsub(/\s+/, '')].pack('H*')
          end
          oss_dir = 'panda'
          oss_path = AliyunOss.instance.put(oss_dir, File.open(file_name), 'content_type': "image/jpeg")
          oss_path
        else
          ''
        end
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

      def shared_path
        File.expand_path('../..', Rails.root) + '/shared/uploads/cache/'
      end
    end
  end
end
