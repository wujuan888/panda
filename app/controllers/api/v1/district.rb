# frozen_string_literal: true

module Api
  module V1
    class District < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::V1::District::ParamsHelpers

      before do
        auth_user
      end

      desc '兽舍区域列表'
      params do
        use :uuid_place_params
      end
      get '/district/list' do
        district_list = if params[:place_id].to_i.zero?
                          ::District.with_delete(false)
                        else
                          ::District.with_place(params[:place_id]).with_delete(false)
                        end
        present districts: (present district_list, with: Entities::Districts::DistrictList),
                response: success_resp
      end

      desc '根据场所获取兽舍区域'
      params do
        use :place_params
      end
      get '/district/base_list' do
        district_list = ::District.with_place(params[:place_id]).with_delete(false)
        present districts: (present district_list, with: Entities::Districts::MinDistrict), response: success_resp
      end

      desc '新建兽舍区域'
      params do
        use :uuid_params
      end
      get '/district/new' do
        present districts: (present ::Place.all, with: Entities::Places::Place), response: success_resp
      end

      desc '新建兽舍区域提交'
      params do
        use :create_params
      end
      post '/district/create' do
        districts = ::District.with_name(params[:name]).with_delete(false)
        return { response: err_resp(ERR_CODE[:POP_UP], '该区域名已存在') } if districts.present?

        ::District.create(params.except(:uuid).merge(user_id: current_user.id))

        present response: success_resp
      end

      desc '获取兽舍区域详情'
      params do
        use :uuid_id_params
      end
      get '/district/info' do
        district = ::District.find(params[:id])

        present district: (present district, with: Entities::Districts::MaxDistrict), response: success_resp
      end

      desc '获取兽舍区域基本信息'
      params do
        use :uuid_id_params
      end
      get '/district/base_info' do
        district = ::District.find(params[:id])

        present district: (present district, with: Entities::Districts::District), response: success_resp
      end

      desc '更新兽舍区域基本信息'
      params do
        use :update_params
      end
      post '/district/update' do
        district = ::District.find(params[:id])
        district.update(params.except(:uuid, :id))

        present response: success_resp
      end

      desc '删除兽舍区域'
      params do
        use :uuid_id_params
      end
      get '/district/delete' do
        district = ::District.find(params[:id])
        district.update(is_delete: true)
        ::Dormitory.with_district(params[:id]).update_all(is_delete: true)
        ::Room.with_district(params[:id]).update_all(is_delete: true)

        present response: success_resp
      end

    end
  end
end
