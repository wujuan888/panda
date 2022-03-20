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
        list = ::PrenatalBehavior.with_panda(params[:panda_id])\
                 .with_start_stop_date(params[:start_date], params[:stop_date])

        present list: (present list, with: Entities::PrenatalBehaviors::MinPrenatalBehavior), response: success_resp
      end

      desc '创建产前行为'
      params do
        use :create_params
      end
      post '/prenatal_behavior/create' do
        record = ::PrenatalBehavior.create(params.except(:uuid, :image_list).merge(user_id: current_user.id))
        if params[:image_list].present?
          params[:image_list].each do |image|
            ::Attachment.create(item_id: record.id, item_type: 'PrenatalBehavior', url: image)
          end
        end

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
