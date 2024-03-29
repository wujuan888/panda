# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class MaxDormitory < Grape::Entity
        expose :id, :name, :place_id, :district_id, :panda_count
        expose :place_name do |instance, _|
          instance.place&.name
        end
        expose :position do |instance, _|
          "#{instance.place&.name}-#{instance.district&.name}"
        end
        expose :panda_count do |instance, _|
          instance.pandas.count
        end
        expose :panda_names do |instance, _|
          instance.pandas.pluck('name')&.join('、')
        end

      end
    end
  end
end
