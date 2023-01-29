# frozen_string_literal: true

module Api
  module Entities
    module TemperatureRecord
      class Data < Grape::Entity
        expose :id, :is_input
        expose :body
        expose :box
      end
    end
  end
end