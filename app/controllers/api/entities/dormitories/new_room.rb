# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class NewRoom < Grape::Entity
        expose :place_id, :district_id, :id
        expose :place_list do |instance, _|
          Entities::Places::Place.represent ::Place.all
        end
        expose :district_list do |instance, _|
          Entities::Districts::MinDistrict.represent ::District.with_place(instance.place_id).with_delete(false)
        end
        expose :dormitory_list do |instance, _|
          Entities::Dormitories::Data.represent ::Dormitory.with_district(instance.district_id).with_delete(false)
        end
      end
    end
  end
end
