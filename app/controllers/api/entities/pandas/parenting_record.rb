# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class ParentingRecord < Grape::Entity
        expose :id, :name, :age, :gender, :dormitory_id, :head_url, :pedigree_number
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
        expose :gender_name do |instance, _|
          ::Panda.gender_str[instance.gender]
        end
        expose :list do |instance, _|
          Entities::ParentingRecords::MinParentingRecord.represent instance.parenting_records
        end
      end
    end
  end
end
