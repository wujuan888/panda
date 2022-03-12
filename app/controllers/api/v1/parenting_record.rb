# frozen_string_literal: true

module Api
  module V1
    class ParentingRecord < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::ParentingRecord::ParamsHelpers

      before do
        auth_user
      end

      desc '熊猫育幼记录'
      params do
        use :uuid_panda_params
      end
      get '/parenting_record/list' do
        panda = Panda.find(params[:id])

        present panda: (present panda, with: Entities::Pandas::ParentingRecord), response: success_resp
      end

      desc '获取药品'
      params do
        use :uuid_params
      end
      get '/parenting_record/drug_list' do
        present drug_list: (present ::Drug.with_type(1), with: Entities::Drug), response: success_resp
      end

      desc '创建育幼记录'
      params do
        use :create_params
      end
      post '/parenting_record/create' do
        record = ::ParentingRecord.create(params.except(:uuid))

        present panda: (present record.panda, with: Entities::Pandas::ParentingRecord), response: success_resp
      end

      desc '获取育幼记录'
      params do
        use :uuid_id_params
      end
      post '/parenting_record/info' do
        record = ::ParentingRecord.find(params[:id])

        present record: (present record, with: Entities::ParentingRecords::MaxParentingRecord), response: success_resp
      end

    end
  end
end
