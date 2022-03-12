# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module PrenatalBehavior
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '产前行为ID'
          end

          params :uuid_panda_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: Integer, desc: '熊猫ID'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: Integer, desc: '熊猫'
            requires :time, type: String, desc: '时间'
            requires :bamboo, type: String, desc: '竹子'
            requires :behavior_event, type: String, desc: '事件'
            requires :behavior_remark, type: String, desc: '行为备注'
            requires :behavior_time, type: String, desc: '行为时间'
            requires :poop, type: String, desc: '大便'
            requires :remark, type: String, desc: '备注'
            requires :wo_tou, type: String, desc: '窝头'
          end

          params :update_params do
            requires :id, type: Integer, desc: '产前行为ID'
            use :create_params
          end

        end
      end
    end
  end
end