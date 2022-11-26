# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class MinPanda < Grape::Entity
        expose :id, :name, :gender, :age, :dormitory_id, :head_url, :pedigree_number
        expose :age_str do |instance, _|
          instance.age_string
        end
        expose :is_ill, :is_lease, :is_pregnant
        expose :dormitory_name do |instance, _|
          instance.dormitory&.name
        end
        expose :gender_name do |instance, _|
          ::Panda.gender_str[instance.gender]
        end
      end
    end
  end
end
