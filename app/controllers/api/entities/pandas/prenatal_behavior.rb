# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class PrenatalBehavior < Grape::Entity
        expose :id, :name, :gender, :dormitory_id, :head_url, :pedigree_number
        expose :dormitory_name do |instance, _|
          instance.dormitory&.name
        end
        expose :is_ill, :is_lease, :is_pregnant
        expose :father_name do |instance, _|
          instance.father&.name
        end
        expose :mother_name do |instance, _|
          instance.mother&.name
        end
        expose :list do |instance, _|
          Entities::PrenatalBehaviors::MinPrenatalBehavior.represent instance.prenatal_behaviors
        end
      end
    end
  end
end
