# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class TemperatureRecord < Grape::Entity
        expose :id
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :temperature_record do |instance, _|
          Entities::TemperatureRecord::Data.represent instance.temperature_record
        end
      end
    end
  end
end
