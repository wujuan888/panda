# frozen_string_literal: true

module Api
  module Entities
    module EatOtherRecord
      class Data < Grape::Entity
        expose :id
        expose :amount
        expose :name
      end
    end
  end
end
