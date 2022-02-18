# frozen_string_literal: true

module Api
  module Helpers
    module UtilsHelpers
      extend ActiveSupport::Concern

      included do
        helpers do
          def number_string(number)
            numbers = (0..9).to_a
            (0...number).map { numbers[rand(numbers.length)] }.join
          end

          # 生成普通的二维码
          def generate_qr_code(url)
            qr_code = RQRCode::QRCode.new(url)
            png = qr_code.as_png(
              bit_depth: 1,
              border_modules: 4,
              color_mode: ChunkyPNG::COLOR_GRAYSCALE,
              color: 'black',
              file: nil,
              fill: 'white',
              module_px_size: 6,
              resize_exactly_to: false,
              resize_gte_to: false,
              size: 340

            )
            # 返回 base64 的格式
            Base64.encode64(png.to_s)
          end

        end
      end

    end
  end
end
