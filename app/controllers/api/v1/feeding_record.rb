# frozen_string_literal: true

module Api
  module V1
    class FeedingRecord < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::FeedingRecord::ParamsHelpers
      helpers Api::Helpers::V1::FeedingRecord::MethodHelpers

      before do
        auth_user
      end

      desc '熊猫饲养记录'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/list' do
        panda = ::Panda.find(params[:panda_id])
        present panda: (present panda, with: Entities::Pandas::FeedingRecord), response: success_resp
      end

      desc '获取熊猫某日的饲养记录'
      params do
        use :uuid_time_params
      end
      get '/feeding_record/time_record' do
        date_record = params[:date].delete('-')
        record = ::FeedingRecord.with_panda(params[:panda_id]).with_date_record(date_record).last
        feeding_record = if record.present?
                           present record, with: Entities::FeedingRecords::MaxFeedingRecord
                         else
                           present ::FeedingRecord.new, with: Entities::FeedingRecords::NewRecord, panda_id: params[:panda_id]
                         end
        present record: feeding_record, is_new: record.blank?, response: success_resp
      end

      desc '新建熊猫的育幼记录'
      params do
        use :uuid_time_params
      end
      get '/feeding_record/you_time_record' do
        date_record = params[:date].delete('-')
        record = ::FeedingRecord.with_panda(params[:panda_id]).with_date_record(date_record).last
        feeding_record = if record.present?
                           present record, with: Entities::FeedingRecords::MaxYouRecord
                         else
                           present ::FeedingRecord.new, with: Entities::FeedingRecords::NewYouRecord, panda_id: params[:panda_id]
                         end
        present record: feeding_record, is_new: record.blank?, response: success_resp
      end

      desc '获取饲养物品'
      params do
        use :uuid_params
      end
      get '/feeding_record/food_list' do
        present food_list: (present ::FeedingRecord.new, with: Entities::FeedingRecords::Food), response: success_resp
      end

      desc '提交新建饲养记录'
      params do
        use :create_params
      end
      post '/feeding_record/create' do
        create_param(params)
        present response: success_resp
      end

      desc '编辑饲养记录'
      params do
        use :update_params
      end
      post '/feeding_record/update' do
        feeding_record = ::FeedingRecord.find(params[:id])
        update_param(params, feeding_record)
        present response: success_resp
      end

      desc '提交新建育幼记录'
      params do
        use :you_create_params
      end
      post '/feeding_record/you_create' do
        you_create_param(params)
        present response: success_resp
      end

      desc '编辑育幼记录'
      params do
        use :you_update_params
      end
      post '/feeding_record/you_update' do
        feeding_record = ::FeedingRecord.find(params[:id])
        you_update_param(params, feeding_record)
        present response: success_resp
      end

      desc '获取饲养记录'
      params do
        use :uuid_id_params
      end
      get '/feeding_record/info' do
        record = ::FeedingRecord.find(params[:id])

        present record: (present record, with: Entities::FeedingRecords::ShowData), response: success_resp
      end

      desc '饲养记录-综合'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/com_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::ComEvaluationRecord), response: success_resp
      end

      desc '列表-体重'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/weight_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::WeightRecord), response: success_resp
      end

      desc '列表-大便'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/poop_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::PoopRecord), response: success_resp
      end

      desc '列表-粘液'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/mucus_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::MucusRecord), response: success_resp
      end

      desc '列表-喂药'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/drug_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::DrugRecord), response: success_resp
      end

      desc '列表-丰容'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/enrichment_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::EnrichmentRecord), response: success_resp
      end

      desc '列表-训练'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/train_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::TrainRecord), response: success_resp
      end

      desc '列表-行为'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/behavior_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::BehaviorRecord), response: success_resp
      end

      desc '列表-特殊状态'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/states_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::StatesRecord), response: success_resp
      end

      desc '列表-奶量'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/milk_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::MilkRecord), response: success_resp
      end

      desc '列表-体温箱温'
      params do
        use :uuid_panda_date_params
      end
      get '/feeding_record/temperature_list' do
        list = ::FeedingRecord.with_panda(params[:panda_id])\
                              .with_start_stop_date(params[:start_date].delete('-'), params[:stop_date].delete('-')).order('time desc')

        present list: (present list, with: Entities::FeedingRecords::TemperatureRecord), response: success_resp
      end
    end
  end
end
