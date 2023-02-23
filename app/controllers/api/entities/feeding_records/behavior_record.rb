# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class BehaviorRecord < Grape::Entity
        expose :id
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :behavior_record do |instance, _|
          Entities::BehaviorRecord::Data.represent instance.behavior_record
        end
      end
    end
  end
end
