# frozen_string_literal: true

module Api
  module Entities
    module WeightRecords
      class MinWeightRecord < Grape::Entity
        expose :id, :daily_gain, :weight
        expose :created_at, format_with: :localtime
      end
    end
  end
end
