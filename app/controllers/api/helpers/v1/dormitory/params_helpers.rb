# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module Dormitory
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_district_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :district_id, type: Integer, desc: '区域ID'
          end

          params :uuid_place_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :place_id, type: Integer, desc: '区域ID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '宿舍ID'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :name, type: String, desc: '名称'
            requires :place_id, type: Integer, desc: '场所ID（基地、卧龙。。。）'
            requires :district_id, type: Integer, desc: '区域ID'
          end

          params :update_params do
            requires :id, type: Integer, desc: '兽舍ID'
            use :create_params
          end

          params :transfer_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: String, desc: '名称'
            requires :place_id, type: Integer, desc: '场所ID（基地、卧龙。。。）'
            requires :district_id, type: Integer, desc: '区域ID'
            requires :dormitory_id, type: Integer, desc: '兽舍ID'
            requires :room_id, type: Integer, desc: '房间ID'
          end

        end
      end
    end
  end
end