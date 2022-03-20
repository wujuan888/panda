# frozen_string_literal: true

module Api
  module V1
    class FeedingRecord < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::FeedingRecord::ParamsHelpers

      before do
        auth_user
      end

      desc '熊猫饲养记录'
      params do
        use :uuid_panda_params
      end
      get '/feeding_record/list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                 .with_start_stop_date(params[:start_date], params[:stop_date])

        present list: (present list, with: Entities::FeedingRecords::MinFeedingRecord), response: success_resp
      end

      desc '获取饲养物品'
      params do
        use :uuid_params
      end
      get '/feeding_record/food_list' do
        present food_list: (present ::FeedingRecord.new, with: Entities::FeedingRecords::Food), response: success_resp
      end

      desc '创建饲养记录'
      params do
        use :create_params
      end
      post '/feeding_record/create' do
        record = ::FeedingRecord.create(params.except(:uuid, :image_list).merge(user_id: current_user.id, time: Time.now))
        if params[:image_list].present?
          params[:image_list].each do |image|
            ::Attachment.create(item_id: record.id, item_type: 'FeedingRecord', url: image)
          end
        end

        present panda: (present record.panda, with: Entities::Pandas::FeedingRecord), response: success_resp
      end

      desc '获取饲养记录'
      params do
        use :uuid_id_params
      end
      post '/feeding_record/info' do
        record = ::FeedingRecord.find(params[:id])

        present record: (present record, with: Entities::FeedingRecords::MaxFeedingRecord), response: success_resp
      end

    end
  end
end
