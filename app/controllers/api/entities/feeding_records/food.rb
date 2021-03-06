# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class Food < Grape::Entity
        expose :drug_list do |_|
          Entities::Drug::Data.represent ::Drug.with_type(1)
        end
        expose :bamboo_list do |_|
          Entities::Bamboo::Data.represent ::Bamboo.all
        end
      end
    end
  end
end
