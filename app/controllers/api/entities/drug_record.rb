# frozen_string_literal: true

module Api
  module Entities
    module DrugRecord
      class Data < Grape::Entity
        expose :id
        expose :dose
        expose :time_record
        expose :drug_id
        expose :drug_name do |instance, _|
          instance.drug&.name
        end
      end
    end
  end
end
