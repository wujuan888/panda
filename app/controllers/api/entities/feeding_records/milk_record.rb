# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class MilkRecord < Grape::Entity
        expose :id
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :milk_record do |instance, _|
          Entities::MilkRecord::Data.represent instance.milk_record
        end
      end
    end
  end
end
