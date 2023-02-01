# frozen_string_literal: true

module Api
  module Entities
    module Rooms
      class Data < Grape::Entity
        expose :id, :name, :place_id, :district_id, :dormitory_id
      end

      class MinData < Grape::Entity
        expose :id, :name
      end

      class New < Grape::Entity
        expose :place_list do |instance, _|
          Entities::Places::Place.represent ::Place.all
        end
        expose :district_list do |instance, option|
          Entities::Districts::MinDistrict.represent ::District.with_place(option[:place_id]).with_delete(false)
        end
        expose :dormitory_list do |instance, option|
          Entities::Dormitories::Data.represent ::Dormitory.with_place(option[:district_id]).with_delete(false)
        end
      end
    end
  end
end
