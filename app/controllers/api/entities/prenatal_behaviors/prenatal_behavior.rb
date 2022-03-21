# frozen_string_literal: true

module Api
  module Entities
    module PrenatalBehaviors
      class PrenatalBehavior < Grape::Entity
        expose :id, :behavior_event
        expose :time, format_with: :datetime
        expose :created_at, format_with: :localtime
        expose :panda do |instance, _|
          Entities::Pandas::BasePanda.represent instance.panda
        end
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :panda_id
        expose :bamboo
        expose :behavior_event
        expose :behavior_remark
        expose :behavior_time
        expose :poop
        expose :remark
        expose :wo_tou
        expose :image_list do |instance, _|
          Entities::Attachment.represent instance.attachments
        end
      end
    end
  end
end
