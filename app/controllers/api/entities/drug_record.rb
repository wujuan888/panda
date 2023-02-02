# frozen_string_literal: true

module Api
  module Entities
    module DrugRecord
      class Data < Grape::Entity
        expose :id
        expose :dose
        expose :remark
        expose :time_record
        expose :drug_id
        expose :user_id
        expose :drug do |instance, _|
          Entities::Drug::Data.represent instance.drug
        end
      end
    end
  end
end
