# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module DrugRecord
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '药品ID'
          end

          params :uuid_panda_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '药物记录ID'
            requires :start_date, type: String, desc: '起始日期'
            requires :stop_date, type: String, desc: '截止日期'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :time, type: String, desc: '时间'
            requires :panda_id, type: Integer, desc: '熊猫'
            requires :drugs, type: String, desc: '药物'
            requires :other, type: String, desc: '其它'
            requires :remark, type: String, desc: '备注'
          end

          params :update_params do
            requires :id, type: Integer, desc: '药物记录ID'
            use :create_params
          end

        end
      end
    end
  end
end