# frozen_string_literal: true

module Api
  module Entities
    module StatesRecord
      class Data < Grape::Entity
        expose :id
        expose :district
        expose :institution
        expose :states_type
        expose :name
        expose :date, format_with: :only_date
      end

      class MaxData < Grape::Entity
        expose :id
        expose :item_id
        expose :district
        expose :institution
        expose :states_type
        expose :name
        expose :date, format_with: :only_date
        expose :item, if: ->(instance, _) { instance.states_type == 1 } do |instance, _|
          Entities::StatesRecord::Data.represent instance.item_record
        end
      end
    end
  end
end
