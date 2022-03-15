# frozen_string_literal: true

module Api
  module Entities
    module Users
      class MinUser < Grape::Entity
        expose :id, :uuid, :real_name
        expose :role_name do |instance, _|
          ::User.roles[instance.role][0]
        end
      end
    end
  end
end
