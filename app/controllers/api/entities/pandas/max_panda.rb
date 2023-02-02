# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class MaxPanda < Grape::Entity
        expose :id, :name, :gender, :age, :head_url, :pedigree_number, :feeding_type, :states
        expose :place_id, :district_id, :dormitory_id, :room_id, :is_death
        expose :dormitory_name do |instance, _|
          instance.dormitory_name
        end
        expose :age_str do |instance, _|
          instance.age_string
        end
        expose :is_ill, :is_lease, :is_pregnant, :birth_date, :remark, :initial_weight
        expose :father_id, :mother_id
        expose :gender_name do |instance, _|
          ::Panda.gender_str[instance.gender]
        end
        expose :dormitory_name do |instance, _|
          instance.dormitory&.name
        end
        expose :father_name do |instance, _|
          instance.father&.name
        end
        expose :mother_name do |instance, _|
          instance.mother&.name
        end
        expose :father_father_name do |instance, _|
          instance.father_father&.name
        end
        expose :father_mother_name do |instance, _|
          instance.father_mother&.name
        end
        expose :mother_father_name do |instance, _|
          instance.mother_father&.name
        end
        expose :mother_mother_name do |instance, _|
          instance.mother_mother&.name
        end
        expose :father_head_url do |instance, _|
          instance.father&.head_url
        end
        expose :mother_head_url do |instance, _|
          instance.mother&.head_url
        end
        expose :father_father_head_url do |instance, _|
          instance.father_father&.head_url
        end
        expose :father_mother_head_url do |instance, _|
          instance.father_mother&.head_url
        end
        expose :mother_father_head_url do |instance, _|
          instance.mother_father&.head_url
        end
        expose :mother_mother_head_url do |instance, _|
          instance.mother_mother&.head_url
        end
      end
    end
  end
end
