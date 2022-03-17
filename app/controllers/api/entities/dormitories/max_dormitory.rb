# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class MaxDormitory < Grape::Entity
        expose :id, :name, :address, :remark
        expose :user_names do |instance, _|
          instance.users.pluck('read_name').join('、')
        end
        expose :user_ids do |instance, _|
          instance.users&.pluck('id')
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
