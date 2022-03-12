# frozen_string_literal: true

module Api
  module Entities
    module Users
      class MaxUser < Grape::Entity
        expose :id, :real_name, :head_url, :phone
        expose :role
        expose :role_name do |instance, _|
          ::User.roles[instance.role][0]
        end
      end
    end
  end
end
