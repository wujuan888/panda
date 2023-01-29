# frozen_string_literal: true

module Api
  module V1
    class Place < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      before do
        auth_user
      end

      desc '场所列表'
      params do
        requires :uuid, type: String, desc: '用户UUID'
      end
      get '/place/list' do
        present places: (present ::Place.all, with: Entities::Places::Place),
                response: success_resp
      end

      desc '场所熊猫统计'
      params do
        requires :uuid, type: String, desc: '用户UUID'
        optional :place_id, type: Integer, desc: '场所ID（基地、卧龙。。。）'
      end
      get '/place/panda_record' do
        record = if params[:place_id].present?
                   ::PandaRecord.with_place(params[:place_id])&.last
                 else
                   ::PandaRecord.with_place(0)&.last
                 end

        present record: (present record, with: Entities::PandaRecord),
                response: success_resp

      end
    end
  end
end
