# frozen_string_literal: true

module Api
  module Entities
    module Users
      class MaxUser < Grape::Entity
        expose :id, :uuid, :real_name, :head_url, :phone
        expose :role, :role_remark
        expose :role_name do |instance, _|
          ::User.roles[instance.role][0]
        end
        expose :is_on_job do |instance, _|
          instance.pass?
        end
      end
    end
  end
end
