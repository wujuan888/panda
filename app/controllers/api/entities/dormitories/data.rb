# frozen_string_literal: true

module Api
  module Entities
    module Dormitories
      class Data < Grape::Entity
        expose :id, :name
      end
    end
  end
end
