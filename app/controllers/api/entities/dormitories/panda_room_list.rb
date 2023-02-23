# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class PandaRoomInfo < Grape::Entity
        expose :id, :name, :place_id, :district_id, :panda_count
        expose :position do |instance, _|
          "#{instance.place&.name}-#{instance.district&.name}"
        end
        expose :panda_list do |instance, _|
          Entities::Pandas::Room.represent instance.pandas
        end
        expose :room_list do |instance, _|
          Entities::Rooms::Data.represent instance.rooms.with_delete(false)
        end

      end
    end
  end
end
