# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module District
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            optional :id, type: Integer, desc: '兽舍区域ID'
          end

          params :uuid_place_params do
            requires :uuid, type: String, desc: '用户UUID'
            optional :place_id, type: Integer, desc: '场所ID（基地、卧龙。。。）'
          end

          params :place_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :place_id, type: Integer, desc: '场所ID（基地、卧龙。。。）'
          end

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :name, type: String, desc: '名称'
            requires :place_id, type: Integer, desc: '场所ID（基地、卧龙。。。）'
          end

          params :update_params do
            requires :id, type: Integer, desc: '兽舍区域ID'
            use :create_params
          end

        end
      end
    end
  end
end