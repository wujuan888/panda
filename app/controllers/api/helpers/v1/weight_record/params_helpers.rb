# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module WeightRecord
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '体重ID'
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
            requires :time, type: String, desc: '日期'
            requires :daily_gain, type: String, desc: '日增重'
            requires :feed_intake, type: String, desc: '采食量'
            requires :feed_ratio, type: String, desc: '采食比'
            requires :other, type: String, desc: '其它'
            requires :weight, type: String, desc: '体重'
          end

          params :update_params do
            requires :id, type: Integer, desc: '体重ID'
            use :create_params
          end

        end
      end
    end
  end
end