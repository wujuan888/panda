# frozen_string_literal: true

module Api
  module Helpers
    module V1
      module User
        module UserParamsHelpers
          extend Grape::API::Helpers

          params :base_data do
            requires :uuid, type: String, desc: '用户UUID'
            requires :real_name, type: String, desc: '用户的真实姓名'
            requires :role, type: Integer, desc: '0：管理员 1：饲养员，2：兽医'
            requires :phone, type: String, desc: '手机号'
            requires :head_url, type: String, desc: '头像'
            optional :role_remark, type: String, desc: '职务备注'
          end

          params :new_data do
            requires :real_name, type: String, desc: '用户的真实姓名'
            requires :role, type: Integer, desc: '0：管理员 1：饲养员，2：兽医'
            requires :phone, type: String, desc: '手机号'
            requires :head_url, type: String, desc: '头像'
            optional :role_remark, type: String, desc: '职务备注'
          end

          params :update_data do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: String, desc: 'ID'
            requires :real_name, type: String, desc: '用户的真实姓名'
            requires :phone, type: String, desc: '手机号'
            requires :head_url, type: String, desc: '头像'
            optional :role_remark, type: String, desc: '职务备注'
            requires :is_on_job, type: Boolean, desc: '在职状态'
          end

          params :openid_data do
            requires :code, type: String, desc: '请传入code'
            requires :iv, type: String, desc: '请传入iv'
            requires :encrypted_data, type: String, desc: '请传入encrypted_data'
          end

          params :uuid_data do
            requires :uuid, type: String, desc: '用户UUID'
          end

          params :uuid_search_params do
            requires :uuid, type: String, desc: '用户UUID'
            optional :real_name_or_phone_cont, type: String, desc: '名称'
          end

          params :breeder_data do
            requires :uuid, type: String, desc: '用户UUID'
            optional :real_name_or_phone_cont, type: String, desc: '姓名或手机号'
          end

          params :uuid_states_data do
            requires :uuid, type: String, desc: '用户UUID'
            requires :id, type: Integer, desc: '用户ID'
          end

        end
      end
    end
  end
end