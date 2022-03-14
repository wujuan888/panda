# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module ParentingRecord
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '育幼ID'
          end

          params :uuid_panda_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: Integer, desc: '熊猫ID'
            requires :start_date, type: String, desc: '起始日期'
            requires :stop_date, type: String, desc: '截止日期'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :panda_id, type: Integer, desc: '熊猫'
            requires :time, type: String, desc: '时间'
            requires :Box_temperature, type: String, desc: '箱温'
            requires :artificial_milk, type: String, desc: '人工乳'
            requires :breast_milk, type: String, desc: '母乳'
            requires :breathe, type: String, desc: '呼吸'
            requires :humidity, type: String, desc: '湿度'
            requires :mental_state, type: String, desc: '精神状态'
            requires :pee, type: String, desc: '小便'
            requires :poop, type: String, desc: '大便'
            requires :skin_temperature, type: String, desc: '肤温'
          end

          params :update_params do
            requires :id, type: Integer, desc: '育幼ID'
            use :create_params
          end

        end
      end
    end
  end
end