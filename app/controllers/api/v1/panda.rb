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
        params[:place_id_eq] = '' if params[:place_id_eq].to_i.zero?
        pandas = ::Panda.with_not_delete.ransack(params.except(:uuid)).result

        present pandas: (present pandas, with: Entities::Pandas::MinPanda), response: success_resp
      end

      desc '熊猫列表 主页搜索'
      params do
        use :uuid_search_params
      end
      get '/panda/search_list' do
        place_name = if params[:place_id_eq].to_i.zero?
                       '全部'
                     else
                       ::Place.find(params[:place_id_eq]).name
                     end
        type_name = if params[:gender_eq].present?
                      ::Panda.gender_str[params[:gender_eq].to_i]
                    elsif params[:states_cont_all].present?
                      params[:states_cont_all]
                    else
                      '在线'
                    end
        pandas = ::Panda.with_not_delete.with_live.ransack(params.except(:uuid)).result

        present pandas: (present pandas, with: Entities::Pandas::MinPanda),
                place_name: place_name, type_name: type_name, response: success_resp
      end

      desc '活着的熊猫列表'
      params do
        use :uuid_search_params
      end
      get '/panda/live_list' do
        pandas = ::Panda.with_live.ransack(params.except(:uuid)).result

        present pandas: (present pandas, with: Entities::Pandas::MinPanda), response: success_resp
      end

      desc '雄性熊猫列表'
      params do
        use :uuid_father_params
      end
      get '/panda/father_list' do
        pandas = ::Panda.with_not_delete.with_gender(1)
        pandas = pandas.with_not(params[:panda_id]) if params[:panda_id].present?

        present pandas: (present pandas, with: Entities::Pandas::MinPanda), response: success_resp
      end

      desc '雌性熊猫列表'
      params do
        use :uuid_father_params
      end
      get '/panda/mother_list' do
        pandas = ::Panda.with_not_delete.with_gender(2)
        pandas = pandas.with_not(params[:panda_id]) if params[:panda_id].present?

        present pandas: (present pandas, with: Entities::Pandas::MinPanda), response: success_resp
      end

      desc '熊猫族谱'
      params do
        use :uuid_genealogy_params
      end
      get '/panda/genealogy' do
        father = ::Panda.find(params[:father_id]) if params[:father_id].present?
        mother = ::Panda.find(params[:mother_id]) if params[:mother_id].present?
        data = { father_name: father&.name,
                 mother_name: mother&.name,
                 father_father_name: father&.father&.name,
                 father_mother_name: father&.mother&.name,
                 mother_father_name: mother&.father&.name,
                 mother_mother_name: mother&.mother&.name,
                 father_head_url: father&.head_url,
                 mother_head_url: mother&.head_url,
                 father_father_head_url: father&.father&.head_url,
                 father_mother_head_url: father&.mother&.head_url,
                 mother_father_head_url: mother&.father&.head_url,
                 mother_mother_head_url: mother&.mother&.head_url }
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
        create_panda(panda.dormitory_id)
        PandaWorker.perform_async(0, { gender: panda.gender, place_id: panda.place_id })

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
        old_place_id = panda.place_id
        change_panda(panda.dormitory_id, params[:dormitory_id])
        panda.update(params.except(:uuid, :id))
        if panda.gender != old_gender
          PandaWorker.perform_async(1, { gender: panda.gender, old_gender: old_gender, states: panda.states,
                                         place_id: panda.place_id, old_place_id: old_place_id })
        end
        present response: success_resp
      end

      desc '删除熊猫'
      params do
        use :uuid_id_params
      end
      get '/panda/delete' do
        panda = ::Panda.find(params[:id])
        dormitory_pull(panda.dormitory_id)
        panda.update_columns(is_delete: true)
        content = { gender: panda.gender, states: panda.states, place_id: panda.place_id }
        PandaWorker.perform_async(40, content)

        present response: success_resp
      end

      desc '更新熊猫生病属性'
      params do
        use :ill_params
      end
      post '/panda/ill_update' do
        panda = ::Panda.find(params[:id])
        panda.update(params.except(:uuid, :id))
        PandaWorker.perform_async(30, { flag: panda.is_ill })

        present response: success_resp
      end

      desc '更新熊猫怀孕属性'
      params do
        use :pregnant_params
      end
      post '/panda/pregnant_update' do
        panda = ::Panda.find(params[:id])
        panda.update(params.except(:uuid, :id))
        PandaWorker.perform_async(20, { flag: panda.is_pregnant })

        present response: success_resp
      end

      desc '更新熊猫出租属性'
      params do
        use :lease_params
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
