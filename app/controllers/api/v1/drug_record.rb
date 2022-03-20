# frozen_string_literal: true

module Api
  module V1
    class DrugRecord < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::DrugRecord::ParamsHelpers

      before do
        auth_user
      end

      desc '熊猫用药记录'
      params do
        use :uuid_panda_params
      end
      get '/drug_record/list' do
        list = ::DrugRecord.with_panda(params[:panda_id]).with_start_stop_date(params[:start_date], params[:stop_date])

        present list: (present list, with: Entities::DrugRecords::MinDrugRecord), response: success_resp
      end

      desc '获取药品'
      params do
        use :uuid_params
      end
      get '/drug_record/drug_list' do
        present drug_list: (present ::Drug.with_type(1), with: Entities::Drug), response: success_resp
      end

      desc '创建用药记录'
      params do
        use :create_params
      end
      post '/drug_record/create' do
        record = ::DrugRecord.create(params.except(:uuid, :image_list).merge(user_id: current_user.id))
        if params[:image_list].present?
          params[:image_list].each do |image|
            ::Attachment.create(item_id: record.id, item_type: 'DrugRecord', url: image)
          end
        end

        present panda: (present record.panda, with: Entities::Pandas::DrugRecord), response: success_resp
      end

      desc '获取用药记录'
      params do
        use :uuid_id_params
      end
      post '/drug_record/info' do
        record = ::DrugRecord.find(params[:id])

        present record: (present record, with: Entities::DrugRecords::MaxDrugRecord), response: success_resp
      end

    end
  end
end
