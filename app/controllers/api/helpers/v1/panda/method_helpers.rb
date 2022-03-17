# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module Panda
        module MethodHelpers
          extend Grape::API::Helpers

          def create_panda(id)
            dormitory_push(id)
          end

          def change_panda(old_id, id)
            dormitory_pull(old_id)
            dormitory_push(id)
          end

          def dormitory_push(id)
            return if id.blank?

            dormitory = ::Dormitory.find(id)
            dormitory.with_lock do
              dormitory.update_columns(panda_count: dormitory.panda_count + 1)
            end
          end

          def dormitory_pull(id)
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