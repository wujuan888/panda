# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class PoopRecord < Grape::Entity
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :poop_record do |instance, _|
          Entities::PoopRecord::Data.represent instance.poop_record
        end
      end
    end
  end
end
