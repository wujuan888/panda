# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module Panda
        module ParamsHelpers
          extend Grape::API::Helpers

          params :uuid_params do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_father_params do
            requires :uuid, type: String, desc: '用户UUID'
            optional :pande_id, type: Integer, desc: '熊猫ID'
          end

          params :uuid_search_params do
            requires :uuid, type: String, desc: '用户UUID'
            optional :name_cont, type: String, desc: '姓名'
            optional :gender_eq, type: Integer, values: [1, 2], desc: '性别'
            optional :name_or_pedigree_number_cont_all, type: String, desc: '姓名或谱系号'
            optional :states_cont_all, type: String, desc: '状态'
            optional :place_id_eq, type: Integer, desc: '所在地'
            optional :birth_date_gteq, type: String, desc: '出生日期 大于等于'
            optional :birth_date_lteq, type: String, desc: '出生日期 小于等于'
          end

          params :uuid_id_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '熊猫ID'
          end

          params :uuid_genealogy_params do
            requires :uuid, type: String, desc: '用户UUID'
            optional :father_id, type: Integer, desc: '父亲ID'
            optional :mother_id, type: Integer, desc: '母亲ID'
          end

          params :create_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :name, type: String, desc: '姓名'
            requires :gender, type: Integer, values: [1, 2], desc: '性别'
            requires :feed_type, type: Integer, values: [0, 1], desc: '饲养类型'
            optional :pedigree_number, type: String, desc: '谱系号'
            optional :birth_date, type: String, desc: '出生日期'
            optional :initial_weight, type: String, desc: '体重'
            optional :mother_id, type: Integer, desc: '母亲ID'
            optional :father_id, type: Integer, desc: '父亲ID'
            optional :place_id, type: Integer, desc: '宿舍场所ID'
            optional :district_id, type: Integer, desc: '宿舍区域ID'
            optional :dormitory_id, type: Integer, desc: '宿舍ID'
            optional :room_id, type: Integer, desc: '宿舍房间号ID'
            optional :head_url, type: Integer, desc: '头像'
            optional :remark, type: String, desc: '备注'
          end

          params :update_params do
            requires :id, type: Integer, desc: '熊猫ID'
            use :create_params
          end

          params :lease_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '熊猫ID'
            optional :is_lease, type: Boolean, desc: '出租'
          end

          params :ill_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '熊猫ID'
            optional :is_ill, type: Boolean, desc: '生病'
          end

          params :pregnant_params do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '熊猫ID'
            optional :is_pregnant, type: Boolean, desc: '怀孕'
          end
        end
      end
    end
  end
end