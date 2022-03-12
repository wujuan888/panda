# frozen_string_literal: true

module Api
  module Entities
    module DrugRecords
      class MinDrugRecord < Grape::Entity
        expose :id, :drugs
        expose :time, format_with: :datetime
      end
    end
  end
end
