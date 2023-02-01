# frozen_string_literal: true

module Api
  module V1
    class Room < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::Room::ParamsHelpers
      before do
        auth_user
      end

      desc '房号列表'
      params do
        use :uuid_dormitory_params
      end
      get '/room/list' do
        room_list = ::Room.with_dormitory(params[:dormitory_id]).with_delete(false)
        present rooms: (present room_list, with: Entities::Rooms::Data),
                response: success_resp
      end

      desc '房号列表'
      params do
        use :uuid_dormitory_params
      end
      get '/room/base_list' do
        room_list = ::Room.with_dormitory(params[:dormitory_id]).with_delete(false)
        present rooms: (present room_list, with: Entities::Rooms::MinData),
                response: success_resp
      end

      desc '新建房号'
      params do
        use :uuid_district_params
      end
      get '/room/new' do
        room = ::Room.new
        present room: (present room, with: Entities::Rooms::New, place_id: params[:place_id], district_id: params[:district_id]),
                response: success_resp
      end

      desc '新建房号提交'
      params do
        use :create_params
      end
      post '/room/create' do
        rooms = ::Room.with_name(params[:name]).with_delete(false)
        return { response: err_resp(ERR_CODE[:POP_UP], '该房号名已存在') } if rooms.present?

        ::Room.create(params.except(:uuid).merge(user_id: current_user.id))

        present response: success_resp
      end

      desc '获取房号基本信息'
      params do
        use :uuid_id_params
      end
      get '/room/base_info' do
        room = ::Room.find(params[:id])

        present room: (present room, with: Entities::Rooms::Data), response: success_resp
      end

      desc '更新房号'
      params do
        use :update_params
      end
      post '/room/update' do
        room = ::Room.find(params[:id])
        room.update(params.except(:uuid, :id))

        present response: success_resp
      end

      desc '删除房号'
      params do
        use :uuid_id_params
      end
      get '/room/delete' do
        room = ::Room.find(params[:id])
        room.update(is_delete: true)

        present response: success_resp
      end

    end
  end
end
