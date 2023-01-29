# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class StatesRecord < Grape::Entity
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :states_records do |instance, _|
          Entities::StatesRecord::Data.represent instance.states_records
        end
      end
    end
  end
end
