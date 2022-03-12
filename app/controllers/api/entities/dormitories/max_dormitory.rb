# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class MaxDormitory < Grape::Entity
        expose :id, :name, :address, :remark, :user_id
        expose :user_name do |instance, _|
          instance.user&.real_name
        end
        expose :panda_ids do |instance, _|
          instance.pandas&.pluck('id')
        end
        expose :panda_names do |instance, _|
          instance.pandas&.pluck('name')&.join('、')
        end
      end
    end
  end
end
