# frozen_string_literal: true

module Api
  module V1
    class WeightRecord < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::WeightRecord::ParamsHelpers
      helpers Api::Helpers::V1::WeightRecord::MethodHelpers

      before do
        auth_user
      end

      desc '熊猫体重记录'
      params do
        use :uuid_panda_params
      end
      get '/weight_record/list' do
        list = ::WeightRecord.with_panda(params[:panda_id])\
                 .with_start_stop_date(params[:start_date], params[:stop_date]).order('created_at desc')

        present list: (present list, with: Entities::WeightRecords::MinWeightRecord), response: success_resp
      end

      desc '熊猫体重趋势'
      params do
        use :uuid_panda_params
      end
      get '/weight_record/change_list' do
        list = ::WeightMonth.with_panda(params[:panda_id])\
                 .with_start_stop_date(params[:start_date], params[:stop_date])
        weight_change_list = weight_year_list(list)

        present list: weight_change_list, response: success_resp
      end

      desc '创建体重记录'
      params do
        use :create_params
      end
      post '/weight_record/create' do
        record = ::WeightRecord.create(params.except(:uuid, :image_list).merge(user_id: current_user.id))
        if params[:image_list].present?
          params[:image_list].each do |image|
            ::Attachment.create(item_id: record.id, item_type: 'WeightRecord', url: image)
          end
        end

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
