# frozen_string_literal: true

module Api
  module Entities
    module EatRecord
      class Data < Grape::Entity
        expose :id, :is_input
        expose :amount
        expose :name
      end
    end
  end
end
