# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class BasePanda < Grape::Entity
        expose :id, :name, :age, :gender, :head_url, :pedigree_number, :states, :feeding_type
        expose :place_id, :district_id, :dormitory_id, :room_id
        expose :dormitory_name do |instance, _|
          instance.dormitory_name
        end
        expose :age_str do |instance, _|
          instance.age_string
        end

        expose :father_name do |instance, _|
          instance.father.present? ? instance.father&.name : ''
        end
        expose :mother_name do |instance, _|
          instance.mother.present? ? instance.mother&.name : ''
        end
        expose :gender_name do |instance, _|
          ::Panda.gender_str[instance.gender]
        end
      end
    end
  end
end
