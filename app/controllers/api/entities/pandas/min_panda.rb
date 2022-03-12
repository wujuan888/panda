# frozen_string_literal: true

module Api
  module Entities
    module Pandas
      class MinPanda < Grape::Entity
        expose :id, :name, :gender, :dormitory_id, :head_url, :pedigree_number
        expose :dormitory_name do |instance, _|
          instance.dormitory&.name
        end
      end
    end
  end
end
