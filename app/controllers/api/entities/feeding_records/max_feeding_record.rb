# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class MaxFeedingRecord < Grape::Entity
        expose :id, :evaluation
        expose :time, format_with: :datetime
        expose :panda do |instance, _|
          Entities::Pandas::BasePanda.represent instance.panda
        end
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :forage_time
        expose :Health_medicine
        expose :apple_ingest
        expose :apple_input
        expose :bamboo_ingest
        expose :bamboo_input
        expose :bamboo_part
        expose :bamboo_variety
        expose :collection
        expose :evaluation
        expose :mucus_time
        expose :mucus_pain
        expose :mucus_quality
        expose :mucus_texture
        expose :poop_color
        expose :poop_element
        expose :poop_quality
        expose :poop_texture
        expose :spiritual
        expose :wo_tou_ingest
        expose :wo_tou_input
        expose :image_list do |instance, _|
          Entities::Attachment.represent instance.attachments
        end
      end
    end
  end
end
