# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class Room < Grape::Entity
        expose :id, :name, :gender, :pedigree_number
        expose :place_id, :district_id, :dormitory_id, :room_id
        expose :age_str do |instance, _|
          instance.age_string
        end
        expose :place_name do |instance, _|
          instance.place&.name
        end
        expose :district_name do |instance, _|
          instance.district&.name
        end
        expose :dormitory_name do |instance, _|
          instance.dormitory&.name
        end
        expose :room_name do |instance, _|
          instance.room&.name
        end
      end
    end
  end
end
