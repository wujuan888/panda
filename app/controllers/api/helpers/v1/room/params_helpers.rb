# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module Room
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_district_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :district_id, type: Integer, desc: '区域ID'
          end

          params :uuid_dormitory_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :dormitory_id, type: Integer, desc: '兽舍ID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '房号ID'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :name, type: String, desc: '名称'
            requires :place_id, type: Integer, desc: '场所ID（基地、卧龙。。。）'
            requires :district_id, type: Integer, desc: '区域ID'
            requires :dormitory_id, type: Integer, desc: '兽舍ID'
          end

          params :update_params do
            requires :id, type: Integer, desc: '房间ID'
            use :create_params
          end

        end
      end
    end
  end
end