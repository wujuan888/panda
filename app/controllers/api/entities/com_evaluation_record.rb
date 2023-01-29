# frozen_string_literal: true

module Api
  module Entities
    module ComEvaluationRecord
      class Data < Grape::Entity
        expose :id, :is_input
        expose :collection
        expose :other
        expose :spiritual
      end
    end
  end
end
