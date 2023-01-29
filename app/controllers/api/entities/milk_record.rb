# frozen_string_literal: true

module Api
  module Entities
    module MilkRecord
      class Data < Grape::Entity
        expose :id, :is_input
        expose :breast_milk
        expose :su_breast_milk
        expose :artificial_milk
        expose :milks
      end
    end
  end
end