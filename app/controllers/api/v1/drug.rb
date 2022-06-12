# frozen_string_literal: true

module Api
  module V1
    class Drug < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::Drug::ParamsHelpers

      before do
        auth_user
      end

      desc '药品列表'
      params do
        use :uuid_params
      end
      get '/drug/list' do
        present drugs: (present ::Drug.all, with: Entities::Drug::MaxData), response: success_resp
      end

      desc '新建药品'
      params do
        use :create_params
      end
      post '/drug/create' do
        drugs = ::Drug.with_name(params[:name])
        return { response: err_resp(ERR_CODE[:POP_UP], '该药品名已存在') } if drugs.present?

        ::Drug.create(params.except(:uuid))

        present response: success_resp
      end

      desc '获取药品详情'
      params do
        use :uuid_id_params
      end
      get '/drug/info' do
        drug = ::Drug.find(params[:id])

        present drug: (present drug, with: Entities::Drug::MaxData), response: success_resp
      end

      desc '更新药品'
      params do
        use :update_params
      end
      post '/drug/update' do
        drug = ::Drug.find(params[:id])
        drug.update(params.except(:uuid, :id))

        present response: success_resp
      end

    end
  end
end
