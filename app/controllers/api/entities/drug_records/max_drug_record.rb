# frozen_string_literal: true

module Api
  module Entities
    module DrugRecords
      class MaxDrugRecord < Grape::Entity
        expose :id, :evaluation
        expose :time, format_with: :datetime
        expose :panda do |instance, _|
          Entities::Pandas::BasePanda.represent instance.panda
        end
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :panda_id
        expose :drugs
        expose :other
        expose :remark
        expose :image_list do |instance, _|
          Entities::Attachment.represent instance.attachments
        end
      end
    end
  end
end
