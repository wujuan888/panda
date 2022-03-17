# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module Dormitory
        module MethodHelpers
          extend Grape::API::Helpers

          def create_panda_change(panda_ids)
            pandas = ::Panda.where(id: panda_ids)
            pandas.each do |panda|
              dormitory = panda.dormitory
              next if dormitory.blank?

              dormitory.with_lock do
                dormitory.update_columns(panda_count: dormitory.panda_count - 1)
              end
            end
          end

          def panda_change(panda_ids, id)
            pandas = ::Panda.where(id: panda_ids)
            pandas.each do |panda|
              dormitory = panda.dormitory
              next if dormitory.blank? || dormitory.id == id

              dormitory.with_lock do
                dormitory.update_columns(panda_count: dormitory.panda_count - 1)
              end
            end
          end

        end
      end
    end
  end
end