# frozen_string_literal: true

module Api
  module V1
    class User < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      helpers Api::Helpers::WeiXinHelpers
      helpers Api::Helpers::V1::User::UserParamsHelpers

      desc '用户注册'
      params do
        use :new_data
      end
      post '/user/register' do
        users = ::User.with_phone(params[:phone])
        return { response: err_resp(ERR_CODE[:POP_UP], '该账户已注册') } if users.present?

        user = ::User.create(params)

        present user: (present user, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '获取微信小程序手机号'
      params do
        use :openid_data
      end
      post '/user/sign' do
        msg = js_code(params[:code])

        logger.info "V1::Customer::register ====  message  #{msg}"

        return { response: err_resp(ERR_CODE[:POP_UP], '访问微信服务器错误') } if msg[:errcode].present?

        phone = decrypt_phone(params[:encrypted_data], params[:iv], msg[:session_key])
        user = ::User.with_openid_or_phone(msg[:openid], phone)&.last

        return { response: err_resp(ERR_CODE[:POP_UP], '该账户不存在') } if user.blank?
        return { response: err_resp(ERR_CODE[:POP_UP], ::User.states_login_names[user.states]) } unless user.pass?

        user.update_columns(openid: msg[:openid])

        present user: (present user, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '获取微信小程序手机号'
      params do
        use :openid_data
      end
      post '/user/get_phone' do
        msg = js_code(params[:code])

        logger.info "V1::Customer::register ====  message  #{msg}"

        return { response: err_resp(ERR_CODE[:POP_UP], '访问微信服务器错误') } if msg[:errcode].present?

        phone = decrypt_phone(params[:encrypted_data], params[:iv], msg[:session_key])
        data = { phone: phone, openid: msg[:openid] }

        present data: data, response: success_resp
      end

      desc '小程序后通过code换取用户uuid'
      params do
        requires :code, type: String, desc: '请传入code'
      end
      get '/user/by_code' do
        msg = js_code(params[:code])

        logger.info "V1::User::by_code ====  message  #{msg}"

        return { response: err_resp(ERR_CODE[:POP_UP], '访问微信服务器错误') } if msg[:errcode].present?

        user = ::User.with_openid(msg[:openid]).with_states(:pass)&.last
        return { response: err_resp(ERR_CODE[:POP_UP], '用户不存在 请先调用注册') } if user.blank?

        present user: (present user, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '通过UUID获取用户基本信息'
      params do
        requires :uuid, type: String, desc: '请传入UUID'
        requires :id, type: String, desc: '请传入ID'
      end
      get '/user/info' do
        auth_user
        user = ::User.find(params[:id])

        present user: (present user, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '更新用户基本信息'
      params do
        use :update_data
      end
      post '/user/update' do
        auth_user
        user = ::User.find(params[:id])
        user.update(params.except(:uuid, :id, :is_on_job))
        states = params[:is_on_job] ? :pass : :resign
        user.update_columns(states: states)

        present response: success_resp
      end

      desc '获取用户'
      params do
        use :uuid_search_params
      end
      get '/user/list' do
        auth_user
        role_arr = [1, 2]
        role_arr.push 0 if current_user.role == 3
        users = ::User.with_states([:pass, :resign]).with_role(role_arr).order('states asc').ransack(params.except(:uuid)).result

        present users: (present users, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '获取饲养员'
      params do
        use :breeder_data
      end
      get '/user/breeder_list' do
        auth_user
        users = ::User.with_role_pass(1).ransack(params.except(:uuid)).result

        present users: (present users, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '获取待审核用户'
      params do
        use :uuid_data
      end
      get '/user/audit_list' do
        auth_user
        role_arr = [1, 2]
        role_arr.push 0 if current_user.role == 3
        users = ::User.with_states(:init).with_role(role_arr)

        present users: (present users, with: Entities::Users::MaxUser), response: success_resp
      end


      desc '拒绝用户申请'
      params do
        use :uuid_states_data
      end
      get '/user/reject' do
        auth_user
        user = ::User.find(params[:id])
        return { response: err_resp(ERR_CODE[:POP_UP], '该用户不存在') } if user.blank?

        user.delete
        users = ::User.with_states(:init)

        present users: (present users, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '通过用户申请'
      params do
        use :uuid_states_data
      end
      get '/user/pass' do
        auth_user
        user = ::User.find(params[:id])
        return { response: err_resp(ERR_CODE[:POP_UP], '该用户不存在') } if user.blank?

        user.update(states: :pass)
        users = ::User.with_states(:init)

        present users: (present users, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '用户离职'
      params do
        use :uuid_states_data
      end
      get '/user/resign' do
        auth_user
        user = ::User.find(params[:id])
        return { response: err_resp(ERR_CODE[:POP_UP], '该用户不存在') } if user.blank?

        user.update(states: :resign)
        users = ::User.with_states(%i[pass resign]).order('states asc')

        present users: (present users, with: Entities::Users::MaxUser), response: success_resp
      end

      desc '管理员获取 熊猫统计'
      params do
        use :uuid_place_data
      end
      get '/user/panda' do
        auth_user
        record = ::PandaRecord.with_place(params[:place_id])

        present record: (present record, with: Entities::PandaRecord), response: success_resp
      end
    end
  end
end
