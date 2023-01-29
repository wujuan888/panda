# frozen_string_literal: true

module Api
  module Entities
    module TrainRecord
      class Data < Grape::Entity
        expose :id
        expose :name
        expose :result
      end
    end
  end
end
