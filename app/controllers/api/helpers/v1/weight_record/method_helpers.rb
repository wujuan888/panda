# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module WeightRecord
        module MethodHelpers
          extend Grape::API::Helpers

          def weight_add(id, weight, date)
            return if id.blank?

            dormitory = ::Dormitory.find(id)
            dormitory.with_lock do
              dormitory.update_columns(panda_count: dormitory.panda_count - 1)
            end
          end
        end
      end
    end
  end
end