# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module FeedingRecord
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '饲养ID'
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
            requires :forage_time, type: String, desc: '采食时间'
            requires :Health_medicine, type: String, desc: '保健药品'
            requires :apple_ingest, type: String, desc: '苹果食入'
            requires :apple_input, type: String, desc: '苹果投给'
            requires :bamboo_ingest, type: String, desc: '竹子食入'
            requires :bamboo_input, type: String, desc: '竹子投给'
            requires :bamboo_part, type: String, desc: '竹子部位'
            requires :bamboo_variety, type: String, desc: '竹子品种'
            requires :collection, type: String, desc: '采集情况'
            requires :evaluation, type: String, desc: '综合评估'
            requires :mucus_time, type: String, desc: '粘液时间'
            requires :mucus_pain, type: String, desc: '粘液痛感'
            requires :mucus_quality, type: String, desc: '粘液质量'
            requires :mucus_texture, type: String, desc: '粘液质地'
            requires :poop_color, type: String, desc: '大便颜色'
            requires :poop_element, type: String, desc: '大便成分'
            requires :poop_quality, type: String, desc: '大便质量'
            requires :poop_texture, type: String, desc: '大便质地'
            requires :spiritual, type: String, desc: '精神活动'
            requires :wo_tou_ingest, type: String, desc: '窝头食入'
            requires :wo_tou_input, type: String, desc: '窝头投给'
          end

          params :update_params do
            requires :id, type: Integer, desc: '饲养ID'
            use :create_params
          end

        end
      end
    end
  end
end