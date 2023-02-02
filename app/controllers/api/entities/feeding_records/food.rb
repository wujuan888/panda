# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class Food < Grape::Entity
        expose :drug_list do |_|
          Entities::Drug::MaxData.represent ::Drug.all
        end
        expose :bamboo_list do |_|
          Entities::Bamboo::Data.represent ::Bamboo.all
        end
      end
    end
  end
end
