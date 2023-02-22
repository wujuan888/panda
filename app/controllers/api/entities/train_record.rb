# frozen_string_literal: true

module Api
  module Entities
    module TrainRecord
      class Data < Grape::Entity
        expose :id
        expose :name
        expose :result
        expose :result_name do |instance, _|
          ::TrainRecord.result_name[instance.result]
        end
      end
    end
  end
end
