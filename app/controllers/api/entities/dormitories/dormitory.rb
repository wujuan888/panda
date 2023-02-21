# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class Dormitory < Grape::Entity
        expose :place_list do |instance, _|
          Entities::Places::Place.represent ::Place.all
        end
        expose :district_list do |instance, _|
          Entities::Districts::MinDistrict.represent ::District.with_place(instance.place_id)
        end
        expose :dormitory_list do |instance, _|
          Entities::Dormitories::Data.represent ::Dormitory.with_district(instance.district_id)
        end
        expose :room_list do |instance, _|
          if instance.new_record?
            []
          else
            Entities::Rooms::MinData.represent ::Room.with_dormitory(instance.id).with_delete(false)
          end
        end
      end
    end
  end
end
