# frozen_string_literal: true

module Api
  module Entities
    module FeedingRecords
      class NewYouRecord < Grape::Entity
        expose :panda do |instance, option|
          Entities::Pandas::BasePanda.represent ::Panda.find(option[:panda_id])
        end
        expose :panda_states_records do |instance, option|
          Entities::StatesRecord::Data.represent ::StatesRecord.with_panda_current(option[:panda_id])
        end
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
