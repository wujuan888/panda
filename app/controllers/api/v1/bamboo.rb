# frozen_string_literal: true

module Api
  module V1
    class Bamboo < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::Bamboo::ParamsHelpers

      before do
        auth_user
      end

      desc '竹子列表'
      params do
        use :uuid_search_params
      end
      get '/bamboo/list' do
        bamboos = ::Bamboo.all.ransack(params.except(:uuid)).result

        present bamboos: (present bamboos, with: Entities::Bamboo::MaxData), response: success_resp
      end

      desc '新建竹子'
      params do
        use :create_params
      end
      post '/bamboo/create' do
        bamboos = ::Bamboo.with_name(params[:name])
        return { response: err_resp(ERR_CODE[:POP_UP], '该竹子名已存在') } if bamboos.present?

        ::Bamboo.create(params.except(:uuid))

        present response: success_resp
      end

      desc '获取竹子详情'
      params do
        use :uuid_id_params
      end
      get '/bamboo/info' do
        bamboo = ::Bamboo.find(params[:id])

        present bamboo: (present bamboo, with: Entities::Bamboo::MaxData), response: success_resp
      end

      desc '更新竹子'
      params do
        use :update_params
      end
      post '/bamboo/update' do
        bamboo = ::Bamboo.find(params[:id])
        bamboo.update(params.except(:uuid, :id))

        present response: success_resp
      end

      desc '删除竹子'
      params do
        use :uuid_id_params
      end
      get '/bamboo/delete' do
        bamboo = ::Bamboo.find(params[:id])
        bamboo.delete

        present response: success_resp
      end

    end
  end
end
