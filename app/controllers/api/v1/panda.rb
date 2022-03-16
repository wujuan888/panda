# frozen_string_literal: true

module Api
  module V1
    class Panda < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::Panda::ParamsHelpers
      helpers Api::Helpers::V1::Panda::MethodHelpers

      before do
        auth_user
      end

      desc '熊猫列表'
      params do
        use :uuid_search_params
      end
      get '/panda/list' do
        pandas = ::Panda.all
        pandas = search_panda(params, pandas)

        present pandas: (present pandas, with: Entities::Pandas::MinPanda), response: success_resp
      end

      desc '雄性熊猫列表'
      params do
        use :uuid_params
      end
      get '/panda/father_list' do
        pandas = ::Panda.with_gender(1)
        present pandas: (present pandas, with: Entities::Pandas::MinPanda), response: success_resp
      end

      desc '雌性熊猫列表'
      params do
        use :uuid_params
      end
      get '/panda/mother_list' do
        pandas = ::Panda.with_gender(2)
        present pandas: (present pandas, with: Entities::Pandas::MinPanda), response: success_resp
      end

      desc '熊猫族谱'
      params do
        use :uuid_genealogy_params
      end
      get '/panda/genealogy' do
        father = ::Panda.find(params[:father_id])
        mother = ::Panda.find(params[:mother_id])
        data = { father_name: father&.name,
                 mother_name: mother&.name,
                 father_father_name: father&.father&.name,
                 father_mother_name: father&.mother&.name,
                 mother_father_name: mother&.father&.name,
                 mother_mother_name: mother&.mother&.name }
        present data: data, response: success_resp
      end

      desc '新建熊猫'
      params do
        use :create_params
      end
      post '/panda/create' do
        pandas = ::Panda.with_name(params[:name])
        return { response: err_resp(ERR_CODE[:POP_UP], '该姓名已存在') } if pandas.present?

        panda = ::Panda.create(params.except(:uuid))
        PandaWorker.perform_async(0, { gender: panda.gender })

        present response: success_resp
      end

      desc '获取熊猫详情'
      params do
        use :uuid_id_params
      end
      get '/panda/info' do
        panda = ::Panda.find(params[:id])

        present panda: (present panda, with: Entities::Pandas::MaxPanda), response: success_resp
      end

      desc '更新熊猫'
      params do
        use :update_params
      end
      post '/panda/update' do
        panda = ::Panda.find(params[:id])
        old_gender = panda.gender
        panda.update(params.except(:uuid, :id))
        PandaWorker.perform_async(1, { gender: panda.gender, old_gender: old_gender }) if panda.gender != old_gender

        present response: success_resp
      end

      desc '更新熊猫生病属性'
      params do
        use :update_params
      end
      post '/panda/ill_update' do
        panda = ::Panda.find(params[:id])
        panda.update(params.except(:uuid, :id))
        PandaWorker.perform_async(30, { flag: panda.is_ill })

        present response: success_resp
      end

      desc '更新熊猫怀孕属性'
      params do
        use :update_params
      end
      post '/panda/pregnant_update' do
        panda = ::Panda.find(params[:id])
        panda.update(params.except(:uuid, :id))
        PandaWorker.perform_async(20, { flag: panda.is_pregnant })

        present response: success_resp
      end

      desc '更新熊猫出租属性'
      params do
        use :update_params
      end
      post '/panda/lease_update' do
        panda = ::Panda.find(params[:id])
        panda.update(params.except(:uuid, :id))
        PandaWorker.perform_async(10, { flag: panda.is_lease })

        present response: success_resp
      end
    end
  end
end
