# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class WeightRecord < Grape::Entity
        expose :time, format_with: :only_date
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :weight
      end
    end
  end
end
