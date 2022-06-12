# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module Bamboo
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '竹子ID'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :name, type: String, desc: '名称'
          end

          params :update_params do
            requires :id, type: Integer, desc: '熊猫ID'
            use :create_params
          end

        end
      end
    end
  end
end