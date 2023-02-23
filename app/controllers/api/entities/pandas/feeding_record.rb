# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class FeedingRecord < Grape::Entity
        expose :id, :name, :gender, :dormitory_id, :head_url, :pedigree_number, :states, :feeding_type, :is_death
        expose :age_str do |instance, _|
          instance.age_string
        end
        expose :gender_name do |instance, _|
          ::Panda.gender_str[instance.gender]
        end
        expose :dormitory_name do |instance, _|
          instance.dormitory_name
        end
        expose :father_name do |instance, _|
          instance.father&.name
        end
        expose :mother_name do |instance, _|
          instance.mother&.name
        end
        expose :list do |instance, _|
          Entities::FeedingRecords::ComEvaluationRecord.represent instance.feeding_records.order('time desc')
        end
      end
    end
  end
end
