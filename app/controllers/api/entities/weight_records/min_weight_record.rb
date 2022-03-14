# frozen_string_literal: true

module Api
  module Entities
    module WeightRecords
      class MinWeightRecord < Grape::Entity
        expose :id, :daily_gain, :weight
        expose :time, format_with: :datetime
      end
    end
  end
end