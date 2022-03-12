# frozen_string_literal: true

module Api
  module V1
    class PrenatalBehavior < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::PrenatalBehavior::ParamsHelpers

      before do
        auth_user
      end

      desc '熊猫产前行为'
      params do
        use :uuid_panda_params
      end
      get '/prenatal_behavior/list' do
        panda = Panda.find(params[:id])

        present panda: (present panda, with: Entities::Pandas::PrenatalBehavior), response: success_resp
      end

      desc '创建产前行为'
      params do
        use :create_params
      end
      post '/prenatal_behavior/create' do
        record = ::PrenatalBehavior.create(params.except(:uuid))

        present panda: (present record.panda, with: Entities::Pandas::PrenatalBehavior), response: success_resp
      end

      desc '获取产前行为'
      params do
        use :uuid_id_params
      end
      post '/prenatal_behavior/info' do
        record = ::PrenatalBehavior.find(params[:id])

        present record: (present record, with: Entities::PrenatalBehaviors::PrenatalBehavior), response: success_resp
      end

    end
  end
end
