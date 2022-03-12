# frozen_string_literal: true

module Api
  module Entities
    module ParentingRecords
      class MinParentingRecord < Grape::Entity
        expose :id, :breast_milk, :mental_state
        expose :time, format_with: :datetime
      end
    end
  end
end
