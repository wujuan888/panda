# frozen_string_literal: true

module Api
  module Entities
    module ParentingRecords
      class MaxParentingRecord < Grape::Entity
        expose :id, :breast_milk, :mental_state
        expose :time, format_with: :datetime
        expose :created_at, format_with: :datetime
        expose :panda do |instance, _|
          Entities::Pandas::BasePanda.represent instance.panda
        end
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :panda_id
        expose :user_id
        expose :Box_temperature
        expose :artificial_milk
        expose :breast_milk
        expose :breathe
        expose :humidity
        expose :mental_state
        expose :pee
        expose :poop
        expose :skin_temperature
        expose :image_list do |instance, _|
          Entities::Attachment.represent instance.attachments
        end
      end
    end
  end
end
