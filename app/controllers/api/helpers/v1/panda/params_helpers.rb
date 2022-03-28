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
            optional :is_ill_eq, type: Boolean, desc: '生病'
            optional :is_pregnant_eq, type: Boolean, desc: '怀孕'
            optional :is_lease_eq, type: Boolean, desc: '出租'
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
            requires :pedigree_number, type: String, desc: '谱系号'
            requires :birth_date, type: String, desc: '出生日期'
            requires :initial_weight, type: String, desc: '体重'
            optional :mother_id, type: Integer, desc: '母亲ID'
            optional :father_id, type: Integer, desc: '父亲ID'
            optional :dormitory_id, type: Integer, desc: '宿舍ID'
            requires :remark, type: String, desc: '备注'
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