# frozen_string_literal: true

module Api
  module V1
    class Dormitory < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::Dormitory::ParamsHelpers
      helpers Api::Helpers::V1::Dormitory::MethodHelpers

      before do
        auth_user
      end

      desc '宿舍列表'
      params do
        use :uuid_params
      end
      get '/dormitory/list' do
        present dormitories: (present ::Dormitory.all, with: Entities::Dormitories::MinDormitory), response: success_resp
      end

      desc '新建宿舍'
      params do
        use :create_params
      end
      post '/dormitory/create' do
        create_panda_change(params[:panda_ids]) if params[:panda_ids].present?
        dormitories = ::Dormitory.with_name(params[:name])
        return { response: err_resp(ERR_CODE[:POP_UP], '该宿舍名已存在') } if dormitories.present?

        ::Dormitory.create(params.except(:uuid).merge(user_id: current_user.id))

        present response: success_resp
      end

      desc '获取宿舍详情'
      params do
        use :uuid_id_params
      end
      get '/dormitory/info' do
        dormitory = ::Dormitory.find(params[:id])

        present dormitory: (present dormitory, with: Entities::Dormitories::MaxDormitory), response: success_resp
      end

      desc '更新宿舍'
      params do
        use :update_params
      end
      post '/dormitory/update' do
        dormitory = ::Dormitory.find(params[:id])
        panda_change(params[:panda_ids], params[:id]) if params[:panda_ids].present?
        dormitory.update(params.except(:uuid, :id))

        present response: success_resp
      end

    end
  end
end
