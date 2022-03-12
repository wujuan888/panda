# frozen_string_literal: true

module Api
  module V1
    class WeightRecord < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::WeightRecord::ParamsHelpers

      before do
        auth_user
      end

      desc '熊猫体重记录'
      params do
        use :uuid_panda_params
      end
      get '/weight_record/list' do
        panda = Panda.find(params[:id])

        present panda: (present panda, with: Entities::Pandas::WeightRecord), response: success_resp
      end

      desc '创建体重记录'
      params do
        use :create_params
      end
      post '/weight_record/create' do
        record = ::WeightRecord.create(params.except(:uuid))

        present panda: (present record.panda, with: Entities::Pandas::WeightRecord), response: success_resp
      end

      desc '获取体重记录'
      params do
        use :uuid_id_params
      end
      post '/weight_record/info' do
        record = ::WeightRecord.find(params[:id])

        present record: (present record, with: Entities::WeightRecords::MaxWeightRecord), response: success_resp
      end

    end
  end
end
