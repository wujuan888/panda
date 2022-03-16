# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class MaxPanda < Grape::Entity
        expose :id, :name, :gender, :age, :dormitory_id, :head_url, :pedigree_number
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
      end
    end
  end
end
