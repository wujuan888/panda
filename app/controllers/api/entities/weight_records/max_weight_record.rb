# frozen_string_literal: true

module Api
  module Entities
    module WeightRecords
      class MaxWeightRecord < Grape::Entity
        expose :id, :daily_gain, :weight
        expose :time, format_with: :only_date
        expose :created_at, format_with: :datetime
        expose :panda do |instance, _|
          Entities::Pandas::BasePanda.represent instance.panda
        end
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :panda_id
        expose :daily_gain
        expose :feed_intake
        expose :feed_ratio
        expose :other
        expose :weight
        expose :image_list do |instance, _|
          Entities::Attachment.represent instance.attachments
        end
      end
    end
  end
end
