# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class New < Grape::Entity
        expose :place_list do |instance, _|
          Entities::Places::Place.represent ::Place.all
        end
        expose :district_list do |instance, option|
          Entities::Districts::MinDistrict.represent ::District.with_place(option[:place_id])
        end
      end
    end
  end
end
