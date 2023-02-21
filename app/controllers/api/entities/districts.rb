# frozen_string_literal: true

module Api
  module Entities
    module Districts
      class MinDistrict < Grape::Entity
        expose :id, :name
      end

      class District < Grape::Entity
        expose :id, :name, :place_id
        expose :place_name do |instance, _|
          instance.place.name
        end
      end

      class MaxDistrict < Grape::Entity
        expose :id, :name, :place_id
        expose :place_name do |instance, _|
          instance.place.name
        end
        expose :dormitory_list do |instance, _|
          Entities::Dormitories::Room.represent instance.dormitories.with_delete(false)
        end
      end

      class DistrictList < Grape::Entity
        expose :id, :name
        expose :place_name do |instance, _|
          instance.place&.name
        end
        expose :dormitory_list do |instance, _|
          Entities::Dormitories::Room.represent instance.dormitories.with_delete(false)
        end
      end

    end
  end
end
