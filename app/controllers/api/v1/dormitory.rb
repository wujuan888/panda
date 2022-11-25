# frozen_string_literal: true

module Api
  module V1
    class Dormitory < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::Dormitory::ParamsHelpers
      before do
        auth_user
      end

      desc '兽舍列表'
      params do
        use :uuid_district_params
      end
      get '/dormitory/list' do
        dormitory_list = ::Dormitory.with_district(params[:district_id]).with_delete(false)
        present dormitories: (present dormitory_list, with: Entities::Dormitories::Room),
                response: success_resp
      end

      desc '新建兽舍'
      params do
        use :uuid_place_params
      end
      get '/dormitory/new' do
        dormitory = ::Dormitory.new
        present dormitory: (present dormitory, with: Entities::Dormitories::New, place_id: params[:place_id]),
                response: success_resp
      end

      desc '新建兽舍提交'
      params do
        use :create_params
      end
      post '/dormitory/create' do
        dormitories = ::Dormitory.with_name(params[:name]).with_delete(false)
        return { response: err_resp(ERR_CODE[:POP_UP], '该兽舍名已存在') } if dormitories.present?

        ::Dormitory.create(params.except(:uuid).merge(user_id: current_user.id))

        present response: success_resp
      end

      desc '获取兽舍详情'
      params do
        use :uuid_id_params
      end
      get '/dormitory/info' do
        dormitory = ::Dormitory.find(params[:id])

        present dormitory: (present dormitory, with: Entities::Dormitories::Room), response: success_resp
      end

      desc '获取兽舍基本信息'
      params do
        use :uuid_id_params
      end
      get '/dormitory/base_info' do
        dormitory = ::Dormitory.find(params[:id])

        present dormitory: (present dormitory, with: Entities::Dormitories::MinDormitory), response: success_resp
      end

      desc '更新兽舍'
      params do
        use :update_params
      end
      post '/dormitory/update' do
        dormitory = ::Dormitory.find(params[:id])
        dormitory.update(params.except(:uuid, :id))

        present response: success_resp
      end

      desc '删除兽舍'
      params do
        use :uuid_id_params
      end
      get '/dormitory/delete' do
        dormitory = ::Dormitory.find(params[:id])
        dormitory.update(is_delete: true)
        ::Room.with_district(params[:id]).update_all(is_delete: true)

        present response: success_resp
      end

    end
  end
end
