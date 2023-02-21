# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class Room < Grape::Entity
        expose :id, :name, :place_id, :district_id
        expose :place_name do |instance, _|
          instance.place.name
        end
        expose :district_name do |instance, _|
          instance.district.name
        end
        expose :room_list do |instance, _|
          Entities::Rooms::Data.represent instance.rooms.with_delete(false)
        end
      end
    end
  end
end
